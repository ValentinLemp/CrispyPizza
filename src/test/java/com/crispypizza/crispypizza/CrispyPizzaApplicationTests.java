package com.crispypizza.crispypizza;

import com.crispypizza.crispypizza.dataAcces.repository.ProduitRepository;
import com.crispypizza.crispypizza.dataAcces.repository.TypeProduitRepository;
import com.crispypizza.crispypizza.service.MenuService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class CrispyPizzaApplicationTests
{
	private MenuService service;
	@Mock
	private ProduitRepository repository;
	@Mock
	private TypeProduitRepository typeRepository;

	@BeforeEach
	public void setUp()
	{
		service = new MenuService(repository, typeRepository);
	}

	@Test
	void affichePrix()
	{
		String result = service.affichePrix(10.5);
		assertEquals("10.5€", result);

		result = service.affichePrix(6.5);
		assertEquals("6.5€", result);

		result = service.affichePrix(10.0);
		assertEquals("10€", result);

		result = service.affichePrix(6.0);
		assertEquals("6€", result);
	}

}
