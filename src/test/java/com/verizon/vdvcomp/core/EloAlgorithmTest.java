package com.verizon.vdvcomp.core;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;

public class EloAlgorithmTest {

	EloAlgorithm elo = null;

	@Before
	public void setUp() {
		elo = EloAlgorithm.getInstance();
	}

	@Test
	public void testGetNewRating() {
		assertEquals(-16, elo.getNewRating(0, 0, 0));
	}
	
	@After
	public void cleanUp() {
		elo = null;
	}

}
