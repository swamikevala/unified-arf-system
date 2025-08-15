"""
Web interface for ARF System - Document viewer with comments
"""

from flask import Flask, render_template, request, jsonify, send_file
from flask_cors import CORS
from flask_socketio import SocketIO, emit
import json
from pathlib import Path
from datetime import datetime

app = Flask(__name__)
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.route('/')
def index():
    """Main dashboard"""
    return render_template('index.html')

@app.route('/document')
def document_viewer():
    """PDF viewer with comment interface"""
    return render_template('document.html')

@app.route('/api/document/pdf')
def get_pdf():
    """Serve the compiled PDF"""
    pdf_path = Path("./output/framework.pdf")
    if pdf_path.exists():
        return send_file(pdf_path, mimetype='application/pdf')
    return jsonify({"error": "PDF not found"}), 404

@app.route('/api/comments', methods=['GET'])
def get_comments():
    """Get all comments"""
    comments_file = Path("./output/comments.json")
    if comments_file.exists():
        with open(comments_file, 'r') as f:
            return jsonify(json.load(f))
    return jsonify({"comments": []})

@app.route('/api/comments', methods=['POST'])
def add_comment():
    """Add a new comment"""
    data = request.json
    comment = {
        'id': str(datetime.now().timestamp()),
        'text': data['text'],
        'section': data.get('section', 'general'),
        'timestamp': datetime.now().isoformat(),
        'status': 'pending'
    }
    
    # Load existing comments
    comments_file = Path("./output/comments.json")
    if comments_file.exists():
        with open(comments_file, 'r') as f:
            comments_data = json.load(f)
    else:
        comments_data = {"comments": []}
    
    # Add new comment
    comments_data['comments'].append(comment)
    
    # Save
    with open(comments_file, 'w') as f:
        json.dump(comments_data, f, indent=2)
    
    # Notify via WebSocket
    socketio.emit('new_comment', comment)
    
    return jsonify({"success": True, "comment": comment})

@app.route('/api/status')
def system_status():
    """Get system status"""
    state_file = Path("./state/system_state.pkl")
    if state_file.exists():
        import pickle
        with open(state_file, 'rb') as f:
            state = pickle.load(f)
        return jsonify({
            'last_checkpoint': state['last_checkpoint'].isoformat(),
            'processed_chats': len(state['processed_chats']),
            'pending_validations': len(state['pending_validations']),
            'framework_version': state['current_framework_version']
        })
    return jsonify({"status": "Not initialized"})

@app.route('/api/questions')
def get_questions():
    """Get pending questions for user"""
    questions_file = Path("./output/questions/Questions_For_You.md")
    if questions_file.exists():
        content = questions_file.read_text()
        # Parse markdown to extract questions
        questions = []
        for line in content.split('\n'):
            if line.startswith('- ['):
                questions.append(line[2:])
        return jsonify({"questions": questions})
    return jsonify({"questions": []})

@socketio.on('connect')
def handle_connect():
    """WebSocket connection handler"""
    emit('connected', {'data': 'Connected to ARF System'})

if __name__ == '__main__':
    socketio.run(app, debug=False, port=5000)
