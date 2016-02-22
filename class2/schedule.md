# Schedule of Day 2 class

Monday Feb 22, 2016, 1pm-5pm, with 2-3 breaks for 10-15 min

- Quick review: command line and statistics
- Continue basic intro to statistics: 
  - More of 'PDFs and the Normal Distribution': http://physiology.med.cornell.edu/people/banfelder/qbio/lecture_notes/1.2_pdfs_and_normal_distribution.pdf
  - A practical example of Placebo vs Drug dataset: http://joshaclark.com/wp-content/uploads/2014/06/l6.html
  - P-values and Formal Statistical Tests: http://physiology.med.cornell.edu/people/banfelder/qbio/lecture_notes/1.4_pvals_and_formal_tests.pdf

##### Additional materials

- The Cartoon Guide to Statistics: http://www.amazon.com/Cartoon-Guide-Statistics-Larry-Gonick/dp/0062731025 (We will have a copy at class that anyone is welcome to borrow. It's great!)
- R cheatsheet: https://cran.r-project.org/doc/contrib/Short-refcard.pdf
- Swirl, basic interactive R tutorial with stats: http://swirlstats.com/
- Biomedical Data Science by Rafael Irizarry and Michael Love: http://genomicsclass.github.io/book/

##### Extra plotting code not in links:
>placebo.data <- subset(can, TRT.CODE == 'Placebo') <br>
>aloe.data <- subset(can, TRT.CODE == 'Aloe Juice') <br>
>t.aloe <- t.test(aloe.data$TOTALCIN, aloe.data$TOTALCW4, paired = TRUE) <br>
>t.placebo <- t.test(placebo.data$TOTALCIN, placebo.data$TOTALCW4, paired = TRUE) <br>

>placebo.res <- data.frame(treatment = 'placebo', estimate = t.placebo$estimate, lower = t.placebo$conf.int[1], upper = t.placebo$conf.int[2]) <br>
>aloe.res <- data.frame(treatment = 'aloe', estimate = t.aloe$estimate, lower = t.aloe$conf.int[1], upper = t.aloe$conf.int[2])
>plot.base <- rbind(placebo.res, aloe.res) <br>
>ggplot(plot.base, aes(x = treatment, y = estimate, color = treatment)) + geom_point() + geom_errorbar(aes(ymin= lower, ymax=upper), width=.1) <br>
