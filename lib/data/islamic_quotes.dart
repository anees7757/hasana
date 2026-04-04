class IslamicQuotes {
  static const List<String> quotes = [
    'Sadaqah purifies the heart',
    'The best of you are those who are best to their families',
    'A smile is charity',
    'Speak good or remain silent',
    'The believer does not slander, curse, or speak in obscene ways',
    'Kindness is a mark of faith',
    'Do good and good will come to you',
    'The most beloved deeds are those done consistently',
    'Forgiveness is a virtue of the strong',
    'Patience is half of faith',
    'Gratitude turns what we have into enough',
    'Your smile in your brother\'s face is charity',
    'The strong person is not the one who can wrestle, but the one who controls himself in anger',
    'Whoever believes in Allah and the Last Day should speak good or remain silent',
    'The most beloved places to Allah are the mosques',
    'Make things easy and do not make them difficult',
    'Be kind, for whenever kindness becomes part of something, it beautifies it',
    'The merciful will be shown mercy by the Most Merciful',
    'Good character is the heaviest thing on the scale',
    'Seek knowledge from the cradle to the grave',
    'The best among you is the one who learns the Quran and teaches it',
    'Allah is with those who are patient',
    'Verily, with hardship comes ease',
    'Remember Me, and I will remember you',
    'Take one step towards Allah, He will take ten steps towards you',
    'The best gift a parent can give their child is good manners',
    'Lower your gaze and guard your modesty',
    'Feed the hungry and visit the sick',
    'The best charity is that given in Ramadan',
    'Tie your camel, then put your trust in Allah',
    'Actions are judged by intentions',
    'Give charity without delay, for it stands in the way of calamity',
    'The worldly comforts are not for me',
    'Do not be people without minds of your own',
    'The ink of the scholar is more sacred than the blood of the martyr',
    'He who does not thank people does not thank Allah',
    'The greatest wealth is contentment',
    'Prayer is the pillar of religion',
    'The tongue is the translator of the heart',
    'Humility and kindness are acts of piety',
    'Cleanliness is half of faith',
    'Visit the sick and help those in distress',
    'The seeking of knowledge is obligatory for every Muslim',
    'Take benefit of five before five: youth before old age',
    'The best of people are those most beneficial to others',
    'Whoever relieves a believer\'s distress, Allah will relieve his distress on the Day of Resurrection',
    'Paradise lies under the feet of mothers',
    'Do not get angry and Paradise will be yours',
    'Love for your brother what you love for yourself',
    'The believer\'s shade on the Day of Resurrection will be his charity',
    'Start with yourself before you advise others',
    'The best way to thank Allah is to use His blessings in His obedience',
    'Every good deed is charity',
    'Fear Allah wherever you are',
    'Keep your duty to Allah and treat your parents well',
    'Modesty brings nothing except good',
    'Control your anger for it is a coal that burns the heart',
    'The tongue can bring healing or destruction',
    'Protect yourself from the fire, even with half a date',
    'Give in charity and do not count',
    'Whoever guides someone to goodness will have a reward like the one who does it',
    'Strive for excellence in this world, but work for the Hereafter',
    'The closest a servant comes to his Lord is when he is prostrating',
    'Allah does not burden a soul beyond that it can bear',
    'The best days of this world are the ten days of Dhul-Hijjah',
    'There is reward for kindness to every living thing',
    'Richness is not having many possessions, but richness is contentment of the soul',
    'Death is the destroyer of pleasures',
    'The life of this world is merely temporary enjoyment',
    'The best of speech is the Book of Allah',
    'Stand up for justice even if it be against yourself',
    'Knowledge from which no benefit is derived is like a treasure from which nothing is spent',
    'The world is a prison for the believer and paradise for the disbeliever',
    'Be in this world as if you are a stranger or a traveler',
    'Whoever loves to meet Allah, Allah loves to meet him',
    'Good deeds erase bad deeds',
    'Beware of envy, for envy devours good deeds',
    'A Muslim is the one from whose tongue and hands the people are safe',
    'The best provision is taqwa (consciousness of Allah)',
    'Every soul will taste death',
    'Make use of your health before sickness comes',
    'The best women are those who are righteous',
    'Time is like a sword, if you do not cut it, it will cut you',
    'Whoever treads a path in search of knowledge, Allah makes easy for him the path to Paradise',
    'The true rich person is the one who is content with what Allah has given',
    'A good friend is better than medicine',
    'Lower your voice, indeed the most disagreeable of sounds is the voice of donkeys',
    'The best of you is he who is best to his wife',
    'Fear Allah and treat your children fairly',
    'Whoever shows no mercy will be shown no mercy',
    'A person will be with those whom he loves',
    'The reward of deeds depends upon the intentions',
    'Do not wish to be like anyone except in two cases: a man whom Allah has given wealth and he spends it righteously',
    'Telling lies about me is not like telling lies about anyone else',
    'A strong person is not one who can overpower others',
    'Fasting is a shield from the fire',
    'The night prayer is the honor of the believer',
    'Seeking halal earnings is a duty after the duties',
    'Every innovation is misguidance',
    'Good character is a means to attain the degree of the person who prays at night',
    'May Allah have mercy on a person who knows his own worth',
  ];

  static String getQuoteForDay(int dayNumber) {
    // Use modulo to cycle through quotes
    return quotes[dayNumber % quotes.length];
  }

  static const List<String> comebackQuotes = [
    'Don’t let a break become a stop. The door of good deeds is always open.',
    'Allah loves those who persistently return to Him. Start again with sincerity.',
    'A missed day is just a reason to make today even better. Keep going!',
    'The best of deeds are those done consistently, even if they are small.',
    'Every new day is a fresh chance to earn Allah\'s pleasure.',
    'Your past streak was beautiful, and your next one will be even better.',
  ];

  static String getStreakMessage(int streak, {bool isBroken = false}) {
    if (isBroken && streak == 0) {
      // Use a comeback quote if the streak was broken
      return comebackQuotes[DateTime.now().day % comebackQuotes.length];
    }

    if (streak == 0) {
      return "Every journey begins with a single sincere step.";
    } else if (streak < 3) {
      return "This is not just a streak, it's the start of something beautiful.";
    } else if (streak < 7) {
      return "You're building consistency — small deeds, big rewards.";
    } else if (streak < 14) {
      return "This is not just a streak, it's a habit forming for the sake of Allah.";
    } else if (streak < 30) {
      return "Your consistency is كتابة in your book of deeds. Keep going.";
    } else {
      return "This is no longer a streak — this is who you are becoming.";
    }
  }
}
