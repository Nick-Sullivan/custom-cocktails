
import pytest

from .endpoints import invent


@pytest.fixture(scope='module')
def response():
    request = {'name': 'name', 'ingredients': 'ingredients', 'banned_ingredients': 'banned_ingredients'}
    response = invent(request)
    yield response


@pytest.fixture(scope='module')
def response_body(response):
    body = response.json()
    yield body


def test_it_returns_status_200(response):
    assert response.status_code == 200


def test_it_returns_name(response_body):
    assert 'name' in response_body


def test_it_returns_recipe(response_body):
    assert 'recipe' in response_body
