import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
  // User Info
  String userName = "mlsc dev";
  String userTitle = "flutter pagluu";
  bool isEditing = false;
  late final TextEditingController _nameController;
  late final TextEditingController _titleController;
  
  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Portfolio Entries with enhanced data
  final List<Map<String, dynamic>> portfolioEntries = [
    {
      'title': 'Flutter Developer (Workshop)',
      'subtitle': 'Built interactive UI screens using Stateless and Stateful Widgets.',
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'skills': ['Flutter', 'Dart', 'UI/UX'],
    },
    {
      'title': 'Dart Fundamentals',
      'subtitle': 'Proficient in Dart basics, including OOP and data structures.',
      'icon': Icons.code,
      'color': Colors.teal,
      'skills': ['Dart', 'OOP', 'Async'],
    },
    {
      'title': 'Responsive Layouts',
      'subtitle': 'Mastered Row, Column, Expanded, and Padding widgets for complex UIs.',
      'icon': Icons.dashboard_customize,
      'color': Colors.purple,
      'skills': ['Layout', 'Responsive', 'Widgets'],
    },
    {
      'title': 'State Management',
      'subtitle': 'Understanding setState, InheritedWidget, and modern state solutions.',
      'icon': Icons.settings_suggest,
      'color': Colors.orange,
      'skills': ['State', 'Provider', 'BLoC'],
    },
  ];

  // Skills
  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'level': 0.85, 'color': Colors.blue},
    {'name': 'Dart', 'level': 0.80, 'color': Colors.teal},
    {'name': 'UI/UX', 'level': 0.75, 'color': Colors.purple},
    {'name': 'Git', 'level': 0.70, 'color': Colors.orange},
  ];

  // Social Links
  final List<Map<String, dynamic>> socialLinks = [
    {'icon': FontAwesomeIcons.github, 'url': 'https://github.com/abhinav29102005', 'label': 'GitHub'},
    {'icon': FontAwesomeIcons.linkedin, 'url': 'https://linkedin.com/in/bigboyaks', 'label': 'LinkedIn'},
    {'icon': FontAwesomeIcons.twitter, 'url': 'https://twitter.com/bigboyaksingh', 'label': 'Twitter'},
    {'icon': FontAwesomeIcons.envelope, 'url': 'mailto:asingh2910.official@gmail.com', 'label': 'Email'},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userName);
    _titleController = TextEditingController(text: userTitle);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (isEditing) {
        userName = _nameController.text;
        userTitle = _titleController.text;
      }
      isEditing = !isEditing;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  void _addNewEntry() {
    showDialog(
      context: context,
      builder: (context) {
        String newTitle = '';
        String newSubtitle = '';
        
        return AlertDialog(
          title: const Text('Add Portfolio Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => newTitle = value,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => newSubtitle = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTitle.isNotEmpty && newSubtitle.isNotEmpty) {
                  setState(() {
                    portfolioEntries.add({
                      'title': newTitle,
                      'subtitle': newSubtitle,
                      'icon': Icons.star,
                      'color': Colors.amber,
                      'skills': ['New Skill'],
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Portfolio',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueGrey.shade700,
                      Colors.blueGrey.shade900,
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 20),
                    _buildSocialLinks(),
                    const SizedBox(height: 30),
                    _buildSkillsSection(),
                    const SizedBox(height: 30),
                    _buildPortfolioSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewEntry,
        icon: const Icon(Icons.add),
        label: const Text('Add Entry'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 16),
            
            // Editable Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: isEditing
                      ? TextField(
                          controller: _nameController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        )
                      : Text(
                          userName,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit),
                  color: isEditing ? Colors.green : Colors.blueGrey,
                  onPressed: _toggleEdit,
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Editable Title
            isEditing
                ? TextField(
                    controller: _titleController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  )
                : Text(
                    userTitle,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: FaIcon(link['icon']),
            color: Colors.blueGrey.shade700,
            iconSize: 28,
            tooltip: link['label'],
            onPressed: () => _launchURL(link['url']),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            ...skills.map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill['name'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: skill['level'],
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(skill['color']),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Portfolio Entries',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        const SizedBox(height: 16),
        ...portfolioEntries.map((entry) => _buildPortfolioCard(entry)),
      ],
    );
  }

  Widget _buildPortfolioCard(Map<String, dynamic> entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opened: ${entry['title']}')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: entry['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  entry['icon'],
                  color: entry['color'],
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry['subtitle'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: (entry['skills'] as List<String>).map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: entry['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12,
                              color: entry['color'],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}