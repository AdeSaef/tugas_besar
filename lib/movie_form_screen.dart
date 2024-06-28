import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie.dart';
import 'package:uuid/uuid.dart';

class MovieFormScreen extends StatefulWidget {
  final Movie? movie;

  MovieFormScreen({this.movie});

  @override
  _MovieFormScreenState createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _posterController = TextEditingController();
  final uuid = Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _yearController.text = widget.movie!.year;
      _posterController.text = widget.movie!.poster;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie == null ? 'Add Movie' : 'Edit Movie'),
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
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _posterController,
                decoration: InputDecoration(labelText: 'Poster URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a poster URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.movie == null) {
                      Provider.of<MovieProvider>(context, listen: false).addMovie(
                        Movie(
                          id: uuid.v4(),
                          title: _titleController.text,
                          year: _yearController.text,
                          poster: _posterController.text,
                        ),
                      );
                    } else {
                      Provider.of<MovieProvider>(context, listen: false).updateMovie(
                        widget.movie!.id,
                        Movie(
                          id: widget.movie!.id,
                          title: _titleController.text,
                          year: _yearController.text,
                          poster: _posterController.text,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.movie == null ? 'Add Movie' : 'Update Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
