package com.verizon.vdvcomp.core;

import java.util.StringTokenizer;

public class EloAlgorithm {
	
	public KConst[] kConsts = {};
	private static EloAlgorithm elo = null;
	private EloAlgorithm() {
		String kConstStr = "0-2099=32,2100-2399=24,2490-3000=16";
		StringTokenizer st1 = new StringTokenizer(kConstStr, ",");
		kConsts = new KConst[st1.countTokens()];
		int index = 0;
		while (st1.hasMoreTokens()) {
			String kfr = st1.nextToken();			
			StringTokenizer st2 = new StringTokenizer(kfr, "=");
			String range = st2.nextToken();
			double value = Double.parseDouble(st2.nextToken());
			st2 = new StringTokenizer(range, "-");
			int startIndex = Integer.parseInt(st2.nextToken());
			int endIndex = Integer.parseInt(st2.nextToken());
			kConsts[index++] = new KConst(startIndex, endIndex, value);
		}	
	}

	public static synchronized EloAlgorithm getInstance() {		
		if (elo == null) {
			elo = new EloAlgorithm();			
		}
		return elo;
	}

	public int getNewRating(int rating, int opponentRating, double score) {		
		double KConst = getKConst(rating);
		double expectedScore = getExpectedScore(rating, opponentRating);
		int newRating = calculateNewRating(rating, score, expectedScore, KConst);
		return newRating;
	}

	private int calculateNewRating(int oldRating, double score, double expectedScore, double KConst) {
		return oldRating + (int) (KConst * (score - expectedScore));
	}
	
	private double getKConst(int rating) {
		for (int i = 0; i < kConsts.length; i++)
			if (rating >= kConsts[i].getStartIndex() &&
			rating <= kConsts[i].getEndIndex())
			{
				return kConsts[i].value;
			}
		// return default KConst
		return 24.0;

	}	

	private double getExpectedScore(int rating, int opponentRating) {
		return 1.0 / (1.0 + Math.pow(10.0, ((double) (opponentRating - rating) / 400.0)));
	}

	
	public class KConst {
		private int startIndex, endIndex;
		private double value;

		public KConst(int startIndex, int endIndex, double value) {
			this.startIndex = startIndex;
			this.endIndex = endIndex;
			this.value = value;
		}

		public int getStartIndex() {
			return startIndex;
		}

		public int getEndIndex() {
			return endIndex;
		}

		public double getValue() {
			return value;
		}

		public String toString() {
			return "KConst: " + startIndex + " " + endIndex + " " + value;
		}
	}
	
	public static void main(String args[]) {
		EloAlgorithm elo = EloAlgorithm.getInstance();
		System.out.println(elo.getNewRating(0, 0, 0));		
	}
}
