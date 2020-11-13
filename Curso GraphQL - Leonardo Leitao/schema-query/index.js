const { ApolloServer } = require('apollo-server')
const { importSchema } = require('graphql-import')

const users = [
    {
        id: 1,
        nome: 'João Silva',
        email: 'jsilva@zemail.com',
        idade: 29,
        perfil_id: 1
    }, {
        id: 2,
        nome: 'Rafael Junior',
        email: 'rafajun@wemail.com',
        idade: 31,
        perfil_id: 2
    }, {
        id: 3,
        nome: 'Daniela Smith',
        email: 'danismi@uemail.com',
        idade: 24,
        perfil_id: 1
    }
]

const perfis = [
    {
        id: 1,
        nome: 'Comum'
    },
    {
        id: 2,
        nome: 'Admin'
    }
]

const resolvers = {
    Usuario: {
        salario(usuario) {
            return usuario.salario_real
        },
        perfil(usuario) {
            const selecionados = perfis.filter(p => p.id == usuario.perfil_id)
            return selecionados ? selecionados[0] : null;
        }
    },
    Produto: {
        precoComDesconto(produto) {
            if (produto.desconto)
                return produto.preco - (produto.preco * produto.desconto)
            return produto.preco
        }
    },
    Query: {
        ola() {
            return 'Bom Dia!'
        },
        horaAtual() {
            return new Date
        },
        usuarioLogado() {
            return {
                id: 1,
                nome: 'Ana',
                email: 'a@a.com',
                idade: 23,
                salario_real: 1234.56,
                vip: true
            }
        },
        produtoEmDestaque() {
            return {
                nome: 'Banana',
                preco: 5.23,
                desconto: 0.10
            }
        },
        numerosMegaSena() {
            const crescente = (a, b) => a - b;
            return Array(6).fill(0).map(e => parseInt(Math.random() * 60 + 1)).sort(crescente)
        },
        usuarios() {
            return users
        },
        usuario(_, args) {
            const selecionados = users.filter(u => u.id == args.id)
            return selecionados ? selecionados[0] : null;
        },
        usuario2(_, { id }) {
            const selecionados = users.filter(u => u.id == id)
            return selecionados ? selecionados[0] : null;
        },
        perfils() {
            return perfis;
        },
        perfil(_, { id }) {
            const selecionados = perfis.filter(p => p.id == id)
            return selecionados ? selecionados[0] : null;
        }
    }
}

const server = new ApolloServer({
    typeDefs: importSchema('./schema/index.graphql'),
    resolvers
})

server.listen().then(({ url }) => {
    console.log(`Executando em ${url}`)
})