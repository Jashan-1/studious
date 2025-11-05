// import { useState } from "react";
// import { DashboardLayout } from "@/components/shared/DashboardLayout";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { Button } from "@/components/ui/button";
// import { Badge } from "@/components/ui/badge";
// import { BookOpen, Bookmark } from "lucide-react";

// interface Book {
//   id: string;
//   subject: string;
//   title: string;
//   class: string;
//   coverUrl: string;
//   flipbookUrl: string;
// }

// export default function Books() {
//   const [books] = useState<Book[]>([
//     {
//       id: "1",
//       subject: "Science",
//       title: "Science Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
//       flipbookUrl: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html"
//     },
//     {
//       id: "2",
//       subject: "Mathematics",
//       title: "Mathematics Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jemh1=0-13"
//     },
//     {
//       id: "3",
//       subject: "Social Science",
//       title: "Democratic Politics II",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jess3=0-13"
//     },
//     {
//       id: "4",
//       subject: "English",
//       title: "First Flight - English Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jefl1=0-13"
//     },
//     {
//       id: "5",
//       subject: "Hindi",
//       title: "Kshitij - Hindi Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jhkt1=0-13"
//     }
//   ]);

//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   const openBook = (book: Book) => {
//     setSelectedBook(book);
//   };

//   const closeBook = () => {
//     setSelectedBook(null);
//   };

//   if (selectedBook) {
//     return (
//       <DashboardLayout>
//         <div className="container mx-auto px-4 space-y-4">
//           <div className="flex items-center justify-between">
//             <div>
//               <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
//               <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
//             </div>
//             <div className="flex items-center gap-2">
//               <Button variant="outline" size="icon">
//                 <Bookmark className="h-4 w-4" />
//               </Button>
//               <Button onClick={closeBook}>Close Book</Button>
//             </div>
//           </div>
  
//           <Card className="overflow-hidden">
//             <CardContent className="p-0">
//               <iframe
//                 src={selectedBook.flipbookUrl}
//                 className="w-full h-[calc(100vh-200px)] border-0"
//                 title={selectedBook.title}
//               />
//             </CardContent>
//           </Card>
//         </div>
//       </DashboardLayout>
//     );
//   }

//   return (
//     <DashboardLayout>
//       <div className="container mx-auto px-4 space-y-6">
//         <div>
//           <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
//           <p className="text-muted-foreground">Access your class textbooks and study materials</p>
//         </div>
  
//         <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
//           {books.map((book) => (
//             <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
//               <div className="aspect-[2/3] relative overflow-hidden">
//                 <img
//                   src={book.coverUrl}
//                   alt={book.title}
//                   className="w-full h-full object-cover"
//                 />
//                 <div className="absolute top-2 right-2">
//                   <Badge variant="secondary">{book.class}</Badge>
//                 </div>
//               </div>
//               <CardHeader>
//                 <CardTitle className="text-lg">{book.subject}</CardTitle>
//                 <CardDescription className="text-sm">{book.title}</CardDescription>
//               </CardHeader>
//               <CardContent>
//                 <Button onClick={() => openBook(book)} className="w-full">
//                   <BookOpen className="mr-2 h-4 w-4" />
//                   Open Book
//                 </Button>
//               </CardContent>
//             </Card>
//           ))}
//         </div>
//       </div>
//     </DashboardLayout>
//   );
// }




// import { useState } from "react";
// import { DashboardLayout } from "@/components/shared/DashboardLayout";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { Button } from "@/components/ui/button";
// import { Badge } from "@/components/ui/badge";
// import { BookOpen, Bookmark, ExternalLink } from "lucide-react";

// interface Chapter {
//   name: string;
//   url: string;
// }

// interface Book {
//   id: string;
//   subject: string;
//   title: string;
//   class: string;
//   coverUrl: string;
//   flipbookUrl: string;
//   chapters?: Chapter[];
// }

// export default function Books() {
//   const [books] = useState<Book[]>([
//     {
//       id: "1",
//       subject: "Science",
//       title: "Science Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jesc1=0-13",
//       chapters: [
//         { name: "Chapter 1", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html" },
//         { name: "Chapter 2", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc102/index.html" },
//         { name: "Chapter 3", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc103/index.html" },
//         { name: "Chapter 4", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc104/index.html" },
//         { name: "Chapter 5", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc105/index.html" },
//         { name: "Chapter 6", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc106/index.html" },
//         { name: "Chapter 7", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc107/index.html" },
//         { name: "Chapter 8", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc108/index.html" },
//         { name: "Chapter 9", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc109/index.html" },
//         { name: "Chapter 10", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc110/index.html" },
//         { name: "Chapter 11", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc111/index.html" },
//         { name: "Chapter 12", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc112/index.html" },
//         { name: "Chapter 13", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc113/index.html" },
//       ],
//     },
//     {
//       id: "2",
//       subject: "Mathematics",
//       title: "Mathematics Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jemh1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "3",
//       subject: "Social Science",
//       title: "Democratic Politics II",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jess3=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "4",
//       subject: "English",
//       title: "First Flight - English Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jefl1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "5",
//       subject: "Hindi",
//       title: "Kshitij - Hindi Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jhkt1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//   ]);

//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   const openInNewTab = (url: string) => {
//     window.open(url, '_blank', 'noopener,noreferrer');
//   };

//   const openBook = (book: Book) => {
//     setSelectedBook(book);
//   };

//   const openChapter = (chapterUrl: string) => {
//     openInNewTab(chapterUrl);
//   };

//   const openFullBook = (bookUrl: string) => {
//     openInNewTab(bookUrl);
//   };

//   const closeBook = () => {
//     setSelectedBook(null);
//   };

//   if (selectedBook) {
//     const hasChapters = selectedBook.chapters && selectedBook.chapters.length > 0;
//     return (
//       <DashboardLayout>
//         <div className="container mx-auto px-4 pt-6 space-y-4">
//           <div className="flex items-center justify-between">
//             <div>
//               <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
//               <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
//             </div>
//             <div className="flex items-center gap-2">
//               <Button variant="outline" size="icon">
//                 <Bookmark className="h-4 w-4" />
//               </Button>
//               <Button onClick={closeBook}>Back to Books</Button>
//             </div>
//           </div>

//           {hasChapters && (
//             <div className="space-y-2">
//               <p className="text-sm font-medium text-muted-foreground">Chapters:</p>
//               <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
//                 {selectedBook.chapters.map((chapter) => (
//                   <Button
//                     key={chapter.name}
//                     variant="outline"
//                     size="sm"
//                     onClick={() => openChapter(chapter.url)}
//                     className="truncate justify-start"
//                   >
//                     <ExternalLink className="mr-2 h-3 w-3" />
//                     {chapter.name}
//                   </Button>
//                 ))}
//               </div>
//             </div>
//           )}

//           <div className="space-y-2">
//             <p className="text-sm font-medium text-muted-foreground">Full Book:</p>
//             <Button onClick={() => openFullBook(selectedBook.flipbookUrl)} variant="default" size="lg" className="w-full">
//               <BookOpen className="mr-2 h-4 w-4" />
//               Open Full Book (NCERT)
//             </Button>
//           </div>

//           {!hasChapters && (
//             <div className="pt-4 text-center">
//               <p className="text-sm text-muted-foreground mb-4">
//                 Chapters will be available soon. For now, open the full book.
//               </p>
//             </div>
//           )}
//         </div>
//       </DashboardLayout>
//     );
//   }

//   return (
//     <DashboardLayout>
//       <div className="container mx-auto px-4 pt-6 space-y-6">
//         <div>
//           <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
//           <p className="text-muted-foreground">Access your class textbooks and study materials</p>
//         </div>

//         <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
//           {books.map((book) => (
//             <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
//               <div className="aspect-[2/3] relative overflow-hidden">
//                 <img
//                   src={book.coverUrl}
//                   alt={book.title}
//                   className="w-full h-full object-cover"
//                 />
//                 <div className="absolute top-2 right-2">
//                   <Badge variant="secondary">{book.class}</Badge>
//                 </div>
//               </div>
//               <CardHeader>
//                 <CardTitle className="text-lg">{book.subject}</CardTitle>
//                 <CardDescription className="text-sm">{book.title}</CardDescription>
//               </CardHeader>
//               <CardContent>
//                 <Button onClick={() => openBook(book)} className="w-full">
//                   <BookOpen className="mr-2 h-4 w-4" />
//                   {book.chapters && book.chapters.length > 0 ? "View Chapters & Book" : "View Book"}
//                 </Button>
//               </CardContent>
//             </Card>
//           ))}
//         </div>
//       </div>
//     </DashboardLayout>
//   );
// }





// import { useState } from "react";
// import { DashboardLayout } from "@/components/shared/DashboardLayout";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { Button } from "@/components/ui/button";
// import { Badge } from "@/components/ui/badge";
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from "@/components/ui/select";
// import { BookOpen, Bookmark, ExternalLink } from "lucide-react";

// interface Chapter {
//   name: string;
//   url: string;
// }

// interface Book {
//   id: string;
//   subject: string;
//   title: string;
//   class: string;
//   coverUrl: string;
//   flipbookUrl: string;
//   chapters?: Chapter[];
// }

// export default function Books() {
//   const [selectedLanguage, setSelectedLanguage] = useState("English");
//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   const allBooks: Book[] = [
//     // Mathematics variants
//     {
//       id: "math-en",
//       subject: "Mathematics (English)",
//       title: "Mathematics",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jemh1=0-13",
//       chapters: [
//         { name: "Chapter 1", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh101/index.html" },
//         { name: "Chapter 2", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh102/index.html" },
//         { name: "Chapter 3", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh103/index.html" },
//         { name: "Chapter 4", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh104/index.html" },
//         { name: "Chapter 5", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh105/index.html" },
//         { name: "Chapter 6", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh106/index.html" },
//         { name: "Chapter 7", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh107/index.html" },
//         { name: "Chapter 8", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh108/index.html" },
//         { name: "Chapter 9", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh109/index.html" },
//         { name: "Chapter 10", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh110/index.html" },
//         { name: "Chapter 11", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh111/index.html" },
//         { name: "Chapter 12", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh112/index.html" },
//         { name: "Chapter 13", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh113/index.html" },
//         { name: "Chapter 14", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh114/index.html" },
//       ],
//     // Add more from full CSV (e.g., Social Science, English, Hindi, Sanskrit variants) here...
//   },
  
// ];

//   const filteredBooks = allBooks.filter((book) =>
//     book.subject.includes(`(${selectedLanguage})`)
//   );

//   const openInNewTab = (url: string) => {
//     window.open(url, "_blank", "noopener,noreferrer");
//   };

//   const openBook = (book: Book) => {
//     setSelectedBook(book);
//   };

//   const openChapter = (chapterUrl: string) => {
//     openInNewTab(chapterUrl);
//   };

//   const openFullBook = (bookUrl: string) => {
//     openInNewTab(bookUrl);
//   };

//   const closeBook = () => {
//     setSelectedBook(null);
//   };

//   if (selectedBook) {
//     const hasChapters = selectedBook.chapters && selectedBook.chapters.length > 0;
//     return (
//       <DashboardLayout>
//         <div className="container mx-auto px-4 pt-6 space-y-4">
//           <div className="flex items-center justify-between">
//             <div>
//               <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
//               <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
//             </div>
//             <div className="flex items-center gap-2">
//               <Button variant="outline" size="icon">
//                 <Bookmark className="h-4 w-4" />
//               </Button>
//               <Button onClick={closeBook}>Back to Books</Button>
//             </div>
//           </div>

//           {hasChapters && (
//             <div className="space-y-2">
//               <p className="text-sm font-medium text-muted-foreground">Chapters:</p>
//               <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
//                 {selectedBook.chapters.map((chapter) => (
//                   <Button
//                     key={chapter.name}
//                     variant="outline"
//                     size="sm"
//                     onClick={() => openChapter(chapter.url)}
//                     className="truncate justify-start"
//                   >
//                     <ExternalLink className="mr-2 h-3 w-3" />
//                     {chapter.name}
//                   </Button>
//                 ))}
//               </div>
//             </div>
//           )}

//           {selectedBook.flipbookUrl && (
//             <div className="space-y-2">
//               <p className="text-sm font-medium text-muted-foreground">Full Book:</p>
//               <Button onClick={() => openFullBook(selectedBook.flipbookUrl)} variant="default" size="lg" className="w-full">
//                 <BookOpen className="mr-2 h-4 w-4" />
//                 Open Full Book (NCERT)
//               </Button>
//             </div>
//           )}

//           {!hasChapters && !selectedBook.flipbookUrl && (
//             <div className="pt-4 text-center">
//               <p className="text-sm text-muted-foreground mb-4">Chapters and full book links coming soon.</p>
//             </div>
//           )}
//         </div>
//       </DashboardLayout>
//     );
//   }

//   return (
//     <DashboardLayout>
//       <div className="container mx-auto px-4 pt-6 space-y-6">
//         <div>
//           <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
//           <p className="text-muted-foreground">Access your class textbooks and study materials</p>
//         </div>

//         <div className="flex justify-between items-center mb-4">
//           <span className="text-sm text-muted-foreground">Filter by language:</span>
//           <Select value={selectedLanguage} onValueChange={setSelectedLanguage}>
//             <SelectTrigger className="w-[180px]">
//               <SelectValue />
//             </SelectTrigger>
//             <SelectContent>
//               <SelectItem value="English">English</SelectItem>
//               <SelectItem value="Hindi">Hindi</SelectItem>
//               <SelectItem value="Urdu">Urdu</SelectItem>
//               {/* Add more languages from full CSV if needed */}
//             </SelectContent>
//           </Select>
//         </div>

//         {filteredBooks.length > 0 ? (
//           <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
//             {filteredBooks.map((book) => (
//               <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
//                 <div className="aspect-[2/3] relative overflow-hidden">
//                   <img src={book.coverUrl} alt={book.title} className="w-full h-full object-cover" />
//                   <div className="absolute top-2 right-2">
//                     <Badge variant="secondary">{book.class}</Badge>
//                   </div>
//                 </div>
//                 <CardHeader>
//                   <CardTitle className="text-lg">{book.subject}</CardTitle>
//                   <CardDescription className="text-sm">{book.title}</CardDescription>
//                 </CardHeader>
//                 <CardContent>
//                   <Button onClick={() => openBook(book)} className="w-full">
//                     <BookOpen className="mr-2 h-4 w-4" />
//                     {book.chapters && book.chapters.length > 0 ? "View Chapters & Book" : "View Book"}
//                   </Button>
//                 </CardContent>
//               </Card>
//             ))}
//           </div>
//         ) : (
//           <div className="text-center py-8">
//             <p className="text-muted-foreground">No books available for the selected language yet. Try another!</p>
//           </div>
//         )}
//       </div>
//     </DashboardLayout>
//   );
// }



// import { useState } from "react";
// import { DashboardLayout } from "@/components/shared/DashboardLayout";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { Button } from "@/components/ui/button";
// import { Badge } from "@/components/ui/badge";
// import { BookOpen, Bookmark, ExternalLink } from "lucide-react";
// import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

// interface Chapter {
//   name: string;
//   url: string;
// }

// interface Book {
//   id: string;
//   subject: string;
//   title: string;
//   class: string;
//   coverUrl: string;
//   flipbookUrl: string;
//   chapters?: Chapter[];
// }

// export default function Books() {
//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);
//   const [selectedLanguage, setSelectedLanguage] = useState("English");
//   const [books] = useState<Book[]>([
//     {
//       id: "1",
//       subject: "Science",
//       title: "Science Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
//       flipbookUrl: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html"
//     },
//     {
//       id: "2",
//       subject: "Mathematics",
//       title: "Mathematics Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jemh1=0-13"
//     },
//     {
//       id: "3",
//       subject: "Social Science",
//       title: "Democratic Politics II",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jess3=0-13"
//     },
//     {
//       id: "4",
//       subject: "English",
//       title: "First Flight - English Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jefl1=0-13"
//     },
//     {
//       id: "5",
//       subject: "Hindi",
//       title: "Kshitij - Hindi Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jhkt1=0-13"
//     }
//   ]);

//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   const openBook = (book: Book) => {
//     setSelectedBook(book);
//   };

//   const closeBook = () => {
//     setSelectedBook(null);
//   };

//   if (selectedBook) {
//     return (
//       <DashboardLayout>
//         <div className="container mx-auto px-4 space-y-4">
//           <div className="flex items-center justify-between">
//             <div>
//               <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
//               <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
//             </div>
//             <div className="flex items-center gap-2">
//               <Button variant="outline" size="icon">
//                 <Bookmark className="h-4 w-4" />
//               </Button>
//               <Button onClick={closeBook}>Close Book</Button>
//             </div>
//           </div>
  
//           <Card className="overflow-hidden">
//             <CardContent className="p-0">
//               <iframe
//                 src={selectedBook.flipbookUrl}
//                 className="w-full h-[calc(100vh-200px)] border-0"
//                 title={selectedBook.title}
//               />
//             </CardContent>
//           </Card>
//         </div>
//       </DashboardLayout>
//     );
//   }

//   return (
//     <DashboardLayout>
//       <div className="container mx-auto px-4 space-y-6">
//         <div>
//           <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
//           <p className="text-muted-foreground">Access your class textbooks and study materials</p>
//         </div>
  
//         <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
//           {books.map((book) => (
//             <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
//               <div className="aspect-[2/3] relative overflow-hidden">
//                 <img
//                   src={book.coverUrl}
//                   alt={book.title}
//                   className="w-full h-full object-cover"
//                 />
//                 <div className="absolute top-2 right-2">
//                   <Badge variant="secondary">{book.class}</Badge>
//                 </div>
//               </div>
//               <CardHeader>
//                 <CardTitle className="text-lg">{book.subject}</CardTitle>
//                 <CardDescription className="text-sm">{book.title}</CardDescription>
//               </CardHeader>
//               <CardContent>
//                 <Button onClick={() => openBook(book)} className="w-full">
//                   <BookOpen className="mr-2 h-4 w-4" />
//                   Open Book
//                 </Button>
//               </CardContent>
//             </Card>
//           ))}
//         </div>
//       </div>
//     </DashboardLayout>
//   );
// }




// import { useState } from "react";
// import { DashboardLayout } from "@/components/shared/DashboardLayout";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { Button } from "@/components/ui/button";
// import { Badge } from "@/components/ui/badge";
// import { BookOpen, Bookmark, ExternalLink } from "lucide-react";

// interface Chapter {
//   name: string;
//   url: string;
// }

// interface Book {
//   id: string;
//   subject: string;
//   title: string;
//   class: string;
//   coverUrl: string;
//   flipbookUrl: string;
//   chapters?: Chapter[];
// }

// export default function Books() {
//   const [books] = useState<Book[]>([
//     {
//       id: "1",
//       subject: "Science",
//       title: "Science Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jesc1=0-13",
//       chapters: [
//         { name: "Chapter 1", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html" },
//         { name: "Chapter 2", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc102/index.html" },
//         { name: "Chapter 3", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc103/index.html" },
//         { name: "Chapter 4", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc104/index.html" },
//         { name: "Chapter 5", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc105/index.html" },
//         { name: "Chapter 6", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc106/index.html" },
//         { name: "Chapter 7", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc107/index.html" },
//         { name: "Chapter 8", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc108/index.html" },
//         { name: "Chapter 9", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc109/index.html" },
//         { name: "Chapter 10", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc110/index.html" },
//         { name: "Chapter 11", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc111/index.html" },
//         { name: "Chapter 12", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc112/index.html" },
//         { name: "Chapter 13", url: "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc113/index.html" },
//       ],
//     },
//     {
//       id: "2",
//       subject: "Mathematics",
//       title: "Mathematics Textbook for Class 10",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jemh1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "3",
//       subject: "Social Science",
//       title: "Democratic Politics II",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jess3=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "4",
//       subject: "English",
//       title: "First Flight - English Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jefl1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//     {
//       id: "5",
//       subject: "Hindi",
//       title: "Kshitij - Hindi Textbook",
//       class: "Class 10",
//       coverUrl: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
//       flipbookUrl: "https://ncert.nic.in/textbook.php?jhkt1=0-13",
//       // Add chapters array here in similar format when you have the links
//     },
//   ]);

//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   const openInNewTab = (url: string) => {
//     window.open(url, '_blank', 'noopener,noreferrer');
//   };

//   const openBook = (book: Book) => {
//     setSelectedBook(book);
//   };

//   const openChapter = (chapterUrl: string) => {
//     openInNewTab(chapterUrl);
//   };

//   const openFullBook = (bookUrl: string) => {
//     openInNewTab(bookUrl);
//   };

//   const closeBook = () => {
//     setSelectedBook(null);
//   };

//   if (selectedBook) {
//     const hasChapters = selectedBook.chapters && selectedBook.chapters.length > 0;
//     return (
//       <DashboardLayout>
//         <div className="container mx-auto px-4 pt-6 space-y-4">
//           <div className="flex items-center justify-between">
//             <div>
//               <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
//               <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
//             </div>
//             <div className="flex items-center gap-2">
//               <Button variant="outline" size="icon">
//                 <Bookmark className="h-4 w-4" />
//               </Button>
//               <Button onClick={closeBook}>Back to Books</Button>
//             </div>
//           </div>

//           {hasChapters && (
//             <div className="space-y-2">
//               <p className="text-sm font-medium text-muted-foreground">Chapters:</p>
//               <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
//                 {selectedBook.chapters.map((chapter) => (
//                   <Button
//                     key={chapter.name}
//                     variant="outline"
//                     size="sm"
//                     onClick={() => openChapter(chapter.url)}
//                     className="truncate justify-start"
//                   >
//                     <ExternalLink className="mr-2 h-3 w-3" />
//                     {chapter.name}
//                   </Button>
//                 ))}
//               </div>
//             </div>
//           )}

//           <div className="space-y-2">
//             <p className="text-sm font-medium text-muted-foreground">Full Book:</p>
//             <Button onClick={() => openFullBook(selectedBook.flipbookUrl)} variant="default" size="lg" className="w-full">
//               <BookOpen className="mr-2 h-4 w-4" />
//               Open Full Book (NCERT)
//             </Button>
//           </div>

//           {!hasChapters && (
//             <div className="pt-4 text-center">
//               <p className="text-sm text-muted-foreground mb-4">
//                 Chapters will be available soon. For now, open the full book.
//               </p>
//             </div>
//           )}
//         </div>
//       </DashboardLayout>
//     );
//   }

//   return (
//     <DashboardLayout>
//       <div className="container mx-auto px-4 pt-6 space-y-6">
//         <div>
//           <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
//           <p className="text-muted-foreground">Access your class textbooks and study materials</p>
//         </div>

//         <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
//           {books.map((book) => (
//             <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
//               <div className="aspect-[2/3] relative overflow-hidden">
//                 <img
//                   src={book.coverUrl}
//                   alt={book.title}
//                   className="w-full h-full object-cover"
//                 />
//                 <div className="absolute top-2 right-2">
//                   <Badge variant="secondary">{book.class}</Badge>
//                 </div>
//               </div>
//               <CardHeader>
//                 <CardTitle className="text-lg">{book.subject}</CardTitle>
//                 <CardDescription className="text-sm">{book.title}</CardDescription>
//               </CardHeader>
//               <CardContent>
//                 <Button onClick={() => openBook(book)} className="w-full">
//                   <BookOpen className="mr-2 h-4 w-4" />
//                   {book.chapters && book.chapters.length > 0 ? "View Chapters & Book" : "View Book"}
//                 </Button>
//               </CardContent>
//             </Card>
//           ))}
//         </div>
//       </div>
//     </DashboardLayout>
//   );
// }





import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { BookOpen, Bookmark, ExternalLink } from "lucide-react";

interface Chapter {
  name: string;
  url: string;
}

interface Book {
  id: string;
  subject: string;
  title: string;
  class: string;
  coverUrl: string;
  flipbookUrl: string;
  chapters?: Chapter[];
}

export default function Books() {
  const [selectedLanguage, setSelectedLanguage] = useState("English");
  const [selectedBook, setSelectedBook] = useState<Book | null>(null);

  const allBooks: Book[] = [
    // Mathematics variants
        {
          "id": "math-en",
          "subject": "Mathematics (English)",
          "title": "Mathematics",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jemh1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1062Mathematics/jemh114/index.html" }
          ]
        },
        {
          "id": "math-hi",
          "subject": "Mathematics (Hindi)",
          "title": "Ganit",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1063Ganit/jhmh114/index.html" }
          ]
        },
        {
          "id": "math-ur",
          "subject": "Mathematics (Urdu)",
          "title": "Riyazi",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5013-Mathematics%20(Urdu)/jumh115" }
          ]
        },
      

        {
          "id": "sci-en",
          "subject": "Science (English)",
          "title": "Science",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jesc1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1064Science/jesc113/index.html" }
          ]
        },
        {
          "id": "sci-hi",
          "subject": "Science (Hindi)",
          "title": "Vigyan",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1065Vigyan/jhsc113/index.html" }
          ]
        },
        {
          "id": "sci-ur",
          "subject": "Science (Urdu)",
          "title": "Science (Urdu)",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc115" },
            { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc116" }
          ]
        },
      

        {
          "id": "hindi-ksht-en",
          "subject": "Hindi (English)",
          "title": "Kshitij - 2",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks112/index.html" }
          ]
        },
        {
          "id": "hindi-spar-en",
          "subject": "Hindi (English)",
          "title": "Sparsh",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp110/index.html" }
          ]
        },
        {
          "id": "urdu-sci",
          "subject": "Urdu",
          "title": "Science",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1618465426159-839ce37c48a4?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc115" },
            { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc116" }
          ]
        },
      

        {
          "id": "eng-ff",
          "subject": "English",
          "title": "First Flight",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jefl1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff109/index.html" }
          ]
        },
        {
          "id": "eng-fw",
          "subject": "English",
          "title": "Footprints without Feet Supp. Reader",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp109/index.html" }
          ]
        },
        {
          "id": "eng-we",
          "subject": "English",
          "title": "Words and Expressions",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe201/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe202/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe203/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe204/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe205/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe206/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe207/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe208/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe209/index.html" }
          ]
        },
      

        {
          "id": "hi-ks",
          "subject": "Hindi",
          "title": "Kshitij - 2",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jhkt1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks112/index.html" }
          ]
        },
        {
          "id": "hi-sp",
          "subject": "Hindi",
          "title": "Sparsh",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc115" },
            { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc116" }
          ]
        },
      

        {
          "id": "eng-ff",
          "subject": "English (First Flight)",
          "title": "First Flight",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jefl1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff109/index.html" }
          ]
        },
        {
          "id": "eng-fw",
          "subject": "English (Footprints without Feet)",
          "title": "Footprints without Feet – Supp. Reader",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp109/index.html" }
          ]
        },
        {
          "id": "eng-we",
          "subject": "English (Words and Expressions)",
          "title": "Words and Expressions",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe201/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe202/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe203/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe204/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe205/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe206/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe207/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe208/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe209/index.html" }
          ]
        },
      
        {
          "id": "hi-ks",
          "subject": "Hindi (Kshitij – 2)",
          "title": "Kshitij – 2",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jhkt1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks112/index.html" }
          ]
        },
        {
          "id": "hi-sp",
          "subject": "Hindi (Sparsh)",
          "title": "Sparsh",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc115" },
            { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5014-science-x%20(urdu)/jusc116" }
          ]
        },
      
        {
          "id": "eng-ff",
          "subject": "English (First Flight)",
          "title": "First Flight",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jefl1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1059First%20Flight%20-%20English%20Textbook%20Course%20-%20B/jeff109/index.html" }
          ]
        },
          {
          "id": "eng-fw",
          "subject": "English (Footprints without Feet)",
          "title": "Footprints without Feet Supp. Reader",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1060Footprints%20without%20Feet%20English%20Suppli%20Reader%20CourseB/jefp109/index.html" }
          ]
        },
        {
          "id": "eng-we",
          "subject": "English (Words and Expressions)",
          "title": "Words and Expressions",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe201/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe202/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe203/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe204/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe205/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe206/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe207/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe208/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1076-Words%20and%20Expressions/jewe209/index.html" }
          ]
        },
        {
          "id": "hi-ks",
          "subject": "Hindi (Kshitij – 2)",
          "title": "Kshitij – 2",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jhkt1=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1055Kshitij%20Bhag%20IIHindi%20CourseA/jhks112/index.html" }
          ]
        },
        {
          "id": "hi-sp",
          "subject": "Hindi (Sparsh)",
          "title": "Sparsh",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1057Sparsh%20Bhag%202%20(Dwitiya%20Bhasha)%20Hindi%20Course-B/jhsp114/index.html" }
          ]
        },
        {
          "id": "hi-sy",
          "subject": "Hindi (Sanchayan Bhag – 2)",
          "title": "Sanchayan Bhag – 2",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1058Sanchayan%20Bhag%202,%20Hindi%20Suppli/jhsy103/index.html" }
          ]
        },
        {
          "id": "hi-kr",
          "subject": "Hindi (Kritika)",
          "title": "Kritika",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1056Kritka%20Bhag%202%20Hindi%20Suppl%20CourseA/jhkr103/index.html" }
          ]
        },
      
        {
          "id": "sk-sh",
          "subject": "Sanskrit (Shemushi)",
          "title": "Shemushi",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk110/index.html" }
          ]
        },
        {
          "id": "sk-ab",
          "subject": "Sanskrit (Abhyasvan Bhaav)",
          "title": "Abhyasvan Bhaav",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab114/index.html" }
          ]
        },
        {
          "id": "sk-vy",
          "subject": "Sanskrit (Vyakaranavithi)",
          "title": "Vyakaranavithi",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhvahemusi%20Dwitiya%20BhagSanskrit/jhsk102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk110/index.html" }
          ]
        },
        {
          "id": "sk-ab",
          "subject": "Sanskrit (Abhyasvan Bhaav)",
          "title": "Abhyasvan Bhaav",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab114/index.html" }
          ]
        },
        {
          "id": "sk-vy",
          "subject": "Sanskrit (Vyakaranavithi)",
          "title": "Vyakaranavithi",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva112/index.html" }
          ]
        },
      

        {
          "id": "ur-gz",
          "subject": "Urdu (Gulzar-e-Urdu)",
          "title": "Gulzar-e-Urdu",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-01" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-02" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-03" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-04" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-05" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-06" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-07" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-08" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-09" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-10" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-11" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-12" }
          ]
        },
        {
          "id": "ur-nw",
          "subject": "Urdu (Nawa-e-Urdu)",
          "title": "Nawa-e-Urdu",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june101" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june102" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june103" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june104" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june105" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june106" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june107" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june108" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june109" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june110" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june111" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june112" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june113" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june114" },
            { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june115" },
            { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june116" },
            { "name": "Chapter 17", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june117" },
            { "name": "Chapter 18", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june118" },
            { "name": "Chapter 19", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june119" },
            { "name": "Chapter 20", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june120" },
            { "name": "Chapter 21", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june121" },
            { "name": "Chapter 22", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june122" },
            { "name": "Chapter 23", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june123" }
          ]
        },
        {
          "id": "ur-jp",
          "subject": "Urdu (Jaan Pahchan)",
          "title": "Jaan Pahchan",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "httpshemusi%20Dwitiya%20BhagSanskrit/jhsk102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk110/index.html" }
          ]
        },
        {
          "id": "sk-ab",
          "subject": "Sanskrit (Abhyasvan Bhaav)",
          "title": "Abhyasvan Bhaav",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab114/index.html" }
          ]
        },
        {
          "id": "sk-vy",
          "subject": "Sanskrit (Vyakaranavithi)",
          "title": "Vyakaranavithi",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva112/index.html" }
          ]
        },
      
    
        {
          "id": "ss-cien",
          "subject": "Social Science (Contemporary India – Geography)",
          "title": "Contemporary India – Geography",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1068Contemporary%20IndiaIIGeography/jess107/index.html" }
          ]
        },
        {
          "id": "ss-dp",
          "subject": "Social Science (Democratic Politics – Civics)",
          "title": "Democratic Politics – II",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
          "flipbookUrl": "https://ncert.nic.in/textbook.php?jess3=0-13",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess401/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess402/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess403/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess404/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1072Democratic%20Politics%20II/jess405/index.html" }
          ]
        },
        {
          "id": "ss-icw",
          "subject": "Social Science (India & Contemporary World – History)",
          "title": "India & Contemporary World – II",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess301/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess302/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess303/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess304/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1066India%20and%20the%20Contemporary%20World%20IIHistory/jess305/index.html" }
          ]
        },
        {
          "id": "ss-ued",
          "subject": "Social Science (Understanding Economic Development)",
          "title": "Understanding Economic Development",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess201/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess202/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess203/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess204/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1070Understanding%20Economic%20Development/jess205/index.html" }
          ]
        },

        {
          "id": "ur-gz",
          "subject": "Urdu (Gulzar-e-Urdu)",
          "title": "Gulzar-e-Urdu",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-01" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-02" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-03" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-04" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/hemusi%20Dwitiya%20BhagSanskrit/jhsk102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1061Shemusi%20Dwitiya%20BhagSanskrit/jhsk110/index.html" }
          ]
        },
        {
          "id": "sk-ab",
          "subject": "Sanskrit (Abhyasvan Bhaav)",
          "title": "Abhyasvan Bhaav",
          "class": "Class 10",
          "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
          "flipbookUrl": "",
          "chapters": [
            { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab101/index.html" },
            { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab102/index.html" },
            { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab103/index.html" },
            { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab104/index.html" },
            { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab105/index.html" },
            { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab106/index.html" },
            { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab107/index.html" },
            { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab108/index.html" },
            { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab109/index.html" },
            { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab110/index.html" },
            { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab111/index.html" },
            { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab112/index.html" },
            { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab113/index.html" },
            { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1075%20Abhyasvan%20Bhaav/jsab114/index.html" }
          ]
        },
              {
              "id": "sk-vy",
              "subject": "Sanskrit (Vyakaranavithi)",
              "title": "Vyakaranavithi",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva101/index.html" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva102/index.html" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva103/index.html" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva104/index.html" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva105/index.html" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva106/index.html" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva107/index.html" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva108/index.html" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva109/index.html" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva110/index.html" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva111/index.html" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20IX-X/Vyakaranavithi/jhva112/index.html" }
              ]
            },
            {
              "id": "ur-gz",
              "subject": "Urdu (Gulzar-e-Urdu)",
              "title": "Gulzar-e-Urdu",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-01" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-02" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-03" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-04" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-05" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-06" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-07" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-08" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-09" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-10" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-11" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5019/Chap-12" }
              ]
            },
            {
              "id": "ur-nw",
              "subject": "Urdu (Nawa-e-Urdu)",
              "title": "Nawa-e-Urdu",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june101" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june102" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june103" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june104" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june105" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june106" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june107" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june108" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june109" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june110" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june111" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june112" },
                { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june113" },
                { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june114" },
                { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june115" },
                { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june116" },
                { "name": "Chapter 17", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june117" },
                { "name": "Chapter 18", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june118" },
                { "name": "Chapter 19", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june119" },
                { "name": "Chapter 20", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june120" },
                { "name": "Chapter 21", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june121" },
                { "name": "Chapter 22", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june122" },
                { "name": "Chapter 23", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5012-Nawa-e-Urdu/june123" }
              ]
            },
            {
              "id": "ur-jp",
              "subject": "Urdu (Jaan Pahchan)",
              "title": "Jaan Pahchan",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp101" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp102" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp103" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp104" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp105" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp106" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp107" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp108" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp109" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp110" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp111" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp112" },
                { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp113" },
                { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp114" },
                { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp115" },
                { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp116" },
                { "name": "Chapter 17", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp117" },
                { "name": "Chapter 18", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp118" },
                { "name": "Chapter 19", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp119" },
                { "name": "Chapter 20", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp120" },
                { "name": "Chapter 21", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp121" },
                { "name": "Chapter 22", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5022-Jaan%20Pehchan-X/jujp122" }
              ]
            },
            {
              "id": "ur-dp",
              "subject": "Urdu (Door Paas)",
              "title": "Door Paas",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp101" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp102" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp103" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp104" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp105" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp106" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp107" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp108" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp109" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp110" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp111" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp112" },
                { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp113" },
                { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp114" },
                { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp115" },
                { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp116" },
                { "name": "Chapter 17", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp117" },
                { "name": "Chapter 18", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp118" },
                { "name": "Chapter 19", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp119" }
              ]
            },
            {
              "id": "ur-sr",
              "subject": "Urdu (Sab Rang)",
              "title": "Sab Rang",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_01" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_02" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_03" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_04" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_05" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_06" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_07" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_08" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_09" }
              ]
            },
            {
              "id": "yoga-en",
              "subject": "Yoga (English)",
              "title": "A Healthy Way of Living",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss101" },
                { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss102" },
                { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss103" }
              ]
            },
            {
              "id": "health-en",
              "subject": "Health and Physical Education (English)",
              "title": "Health and Physical Education",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
                { "name": "Chapter 2",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
                { "name": "Chapter 3",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp103" },
                { "name": "Chapter 4",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp104" },
                { "name": "Chapter 5",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp105" },
                { "name": "Chapter 6",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp106" },
                { "name": "Chapter 7",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp107" },
                { "name": "Chapter 8",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp108" },
                { "name": "Chapter 9",  "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp109" },
                { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp110" },
                { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp111" },
                { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp112" },
                { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp113" },
                { "name": "Chapter 14", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp114" },
                { "name": "Chapter 15", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp115" },
                { "name": "Chapter 16", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp116" },
                { "name": "Chapter 17", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp117" },
                { "name": "Chapter 18", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp118" },
                { "name": "Chapter 19", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5023-DOOR%20PASS%20CLASS%20X/judp119" }
              ]
            },
            {
              "id": "ur-sr",
              "subject": "Urdu (Sab Rang)",
              "title": "Sab Rang",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_01" },
                { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_02" },
                { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_03" },
                { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_04" },
                { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_05" },
                { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_06" },
                { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_07" },
                { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_08" },
                { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/5024-Sab%20Rang%20Class%20X/Ch_09" }
              ]
            },
      
        
            {
              "id": "yoga-en",
              "subject": "Yoga (English)",
              "title": "A Healthy Way of Living",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
                { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss101" },
                { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss102" },
                { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/l/sample/basic/index.php?tra=tiyhwlss103" }
              ]
            },
      
            
            {
              "id": "hpe-en",
              "subject": "Health and Physical Education (English)",
              "title": "Health and Physical Education",
              "class": "Class 10",
              "coverUrl": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop",
              "flipbookUrl": "",
              "chapters": [
              { "name": "Chapter 1", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
              { "name": "Chapter 2", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
              { "name": "Chapter 3", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp101/index.html" },
              { "name": "Chapter 4", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp104/index.html" },
              { "name": "Chapter 5", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp105/index.html" },
              { "name": "Chapter 6", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp106/index.html" },
              { "name": "Chapter 7", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp107/index.html" },
              { "name": "Chapter 8", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp108/index.html" },
              { "name": "Chapter 9", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp109/index.html" },
              { "name": "Chapter 10", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp110/index.html" },
              { "name": "Chapter 11", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp111/index.html" },
              { "name": "Chapter 12", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp112/index.html" },
              { "name": "Chapter 13", "url": "https://epathshala.nic.in/wp-content/doc/book/flipbook/Class%20X/1077-Health%20and%20Physical%20Education-X/jehp113/index.html" }
      ]
    }
  ]; // This closes the allBooks array

  const filteredBooks = allBooks.filter((book) =>
    book.subject.includes(`(${selectedLanguage})`)
  );

  const openInNewTab = (url: string) => {
    window.open(url, "_blank", "noopener,noreferrer");
  };

  const openBook = (book: Book) => {
    setSelectedBook(book);
  };

  const openChapter = (chapterUrl: string) => {
    openInNewTab(chapterUrl);
  };

  const openFullBook = (bookUrl: string) => {
    openInNewTab(bookUrl);
  };

  const closeBook = () => {
    setSelectedBook(null);
  };

  if (selectedBook) {
    const hasChapters = selectedBook.chapters && selectedBook.chapters.length > 0;
    const hasFullBook = !!selectedBook.flipbookUrl;
    return (
      <DashboardLayout>
        <div className="container mx-auto px-4 pt-6 space-y-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-foreground">{selectedBook.title}</h1>
              <p className="text-muted-foreground">{selectedBook.subject} • {selectedBook.class}</p>
            </div>
            <div className="flex items-center gap-2">
              <Button variant="outline" size="icon">
                <Bookmark className="h-4 w-4" />
              </Button>
              <Button onClick={closeBook}>Back to Books</Button>
            </div>
          </div>

          {hasFullBook && (
            <div className="space-y-2">
              <p className="text-sm font-medium text-muted-foreground">Full Book:</p>
              <Button onClick={() => openFullBook(selectedBook.flipbookUrl)} variant="default" size="lg" className="w-full">
                <BookOpen className="mr-2 h-4 w-4" />
                Open Full Book (NCERT)
              </Button>
            </div>
          )}

          <div className="flex justify-center">
            <div className="aspect-[2/3] relative overflow-hidden rounded-lg shadow-md max-w-sm w-full">
              <img 
                src={selectedBook.coverUrl} 
                alt={selectedBook.title} 
                className="w-full h-full object-cover" 
              />
              <div className="absolute top-4 right-4 z-10">
                <Badge variant="secondary">
                  {hasFullBook ? "Full Book Available" : selectedBook.class}
                </Badge>
              </div>
            </div>
          </div>

          {hasChapters && (
            <div className="space-y-2">
              <p className="text-sm font-medium text-muted-foreground">Chapters:</p>
              <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
                {selectedBook.chapters.map((chapter) => (
                  <Button
                    key={chapter.name}
                    variant="outline"
                    size="sm"
                    onClick={() => openChapter(chapter.url)}
                    className="truncate justify-start"
                  >
                    <ExternalLink className="mr-2 h-3 w-3" />
                    {chapter.name}
                  </Button>
                ))}
              </div>
            </div>
          )}

          {!hasChapters && !hasFullBook && (
            <div className="pt-4 text-center">
              <p className="text-sm text-muted-foreground mb-4">Chapters and full book links coming soon.</p>
            </div>
          )}
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="container mx-auto px-4 pt-6 space-y-6">
        <div>
          <h1 className="text-3xl font-bold text-foreground">NCERT Books</h1>
          <p className="text-muted-foreground">Access your class textbooks and study materials</p>
        </div>

        <div className="flex justify-between items-center mb-4">
          <span className="text-sm text-muted-foreground">Filter by language:</span>
          <Select value={selectedLanguage} onValueChange={setSelectedLanguage}>
            <SelectTrigger className="w-[180px]">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="English">English</SelectItem>
              <SelectItem value="Hindi">Hindi</SelectItem>
              <SelectItem value="Urdu">Urdu</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {filteredBooks.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {filteredBooks.map((book) => (
              <Card key={book.id} className="overflow-hidden hover:shadow-lg transition-shadow">
                <div className="aspect-[2/3] relative overflow-hidden">
                  <img src={book.coverUrl} alt={book.title} className="w-full h-full object-cover" />
                  <div className="absolute top-2 right-2">
                    <Badge variant="secondary">{book.class}</Badge>
                  </div>
                </div>
                <CardHeader>
                  <CardTitle className="text-lg">{book.subject}</CardTitle>
                  <CardDescription className="text-sm">{book.title}</CardDescription>
                </CardHeader>
                <CardContent>
                  <Button onClick={() => openBook(book)} className="w-full">
                    <BookOpen className="mr-2 h-4 w-4" />
                    {book.chapters && book.chapters.length > 0 ? "View Chapters" : "View Book"}
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>
        ) : (
          <div className="text-center py-8">
            <p className="text-muted-foreground">No books available for the selected language yet. Try another!</p>
          </div>
        )}
      </div>
    </DashboardLayout>
  );
}