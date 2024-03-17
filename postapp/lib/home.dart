import 'package:flutter/material.dart';
import 'models.dart';
import 'apis.dart';

class PostPandaScreen extends StatefulWidget {
  @override
  _PostPandaScreenState createState() => _PostPandaScreenState();
}

class _PostPandaScreenState extends State<PostPandaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ratingController = TextEditingController();
  final _trailerController = TextEditingController();
  final _downloadController = TextEditingController();
  bool _complete = false;

  PostPandaService _postPandaService = PostPandaService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    _trailerController.dispose();
    _downloadController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _postPandaService.postPanda(PostPanda(
          title: _titleController.text,
          description: _descriptionController.text,
          rating: int.parse(_ratingController.text),
          trailer: _trailerController.text,
          download: _downloadController.text,
          complete: _complete,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Panda posted successfully')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post panda')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: Text('Post Panda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid rating';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _trailerController,
                decoration: InputDecoration(labelText: 'Trailer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a trailer URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _downloadController,
                decoration: InputDecoration(labelText: 'Download'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a download URL';
                }
                  return null;
                },
              ),
              CheckboxListTile(
                value: _complete,
                onChanged: (value) {
                  setState(() {
                    _complete = value!;
                  });
                },
                title: Text('Complete'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Post Panda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}