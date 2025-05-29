
# 📊 ENEM CLI - Interface de Linha de Comando para Análise dos Microdados

Este utilitário permite realizar análises estatísticas dos microdados do ENEM diretamente via terminal, de forma automatizada e reprodutível.

---

## ✅ Pré-requisitos

- R instalado no sistema
- Scripts organizados com:
  - `main.R` (script principal)
  - `conf/config.R` (arquivo de configuração com diretórios)
  - Diretórios como `data/`, `temp/`, `work/` (ajustáveis)

---

## 🚀 Uso

```bash
Rscript enem.R <comando> [opções]
```

---

## 🧾 Comandos e Parâmetros

### 🔹 `sample` – Gerar uma amostra dos dados

Cria uma amostra com base em percentual dos candidatos que compareceram a todas as provas.

**Parâmetros:**

- `-f <file>`: **(Obrigatório)** caminho do arquivo `.csv` dos microdados.
- `-p <percent>`: **(Opcional)** percentual da amostra (ex: `1`, `10`). Padrão: `1`.
- `-s <seed>`: **(Opcional)** número para tornar a amostra reprodutível. Se omitido, uma seed aleatória será usada.

**Exemplo:**

```bash
Rscript enem.R sample -f data/microdados.csv -p 1 -s 42
```

---

### 🔹 `sd` – Calcular desvio padrão

Calcula o desvio padrão das variáveis numéricas especificadas.

**Parâmetros:**

- `-v <var1,var2,...>`: **(Obrigatório)** lista de variáveis separadas por vírgula.

**Exemplo:**

```bash
Rscript enem.R sd -v NU_NOTA_CN,NU_NOTA_CH
```

---

### 🔹 `bp` – Gerar boxplots

Cria gráficos boxplot para cada variável numérica especificada.

**Parâmetros:**

- `-v <var1,var2,...>`: **(Obrigatório)** variáveis numéricas para análise.

**Exemplo:**

```bash
Rscript enem.R bp -v NU_NOTA_MT,NU_NOTA_LC
```

---

### 🔹 `anova` – Análise de variância

Executa uma ANOVA entre variáveis numéricas e uma variável categórica.

**Parâmetros:**

- `-v <var1,var2,...>`: **(Obrigatório)** variáveis numéricas a serem analisadas.
- `-c <var_comparacao>`: **(Obrigatório)** variável categórica para comparação (ex: `Q006`).

**Exemplo:**

```bash
Rscript enem.R anova -v NU_NOTA_CH,NU_NOTA_CN -c Q006
```

---

### 🔹 `summary` – Estatísticas descritivas

Gera resumo estatístico das variáveis da amostra atual.

**Parâmetros:** Nenhum.

**Exemplo:**

```bash
Rscript enem.R summary
```

---

### 🔹 `lm` – Regressão linear

Executa uma regressão linear sobre as variáveis da amostra.

**Parâmetros:** Nenhum.

**Exemplo:**

```bash
Rscript enem.R lm
```

---

## 📂 Saídas

- A amostra gerada é salva em: `temp/amostra_enem.rds`
- Gráficos e resultados são salvos em arquivos PDF em `temp/`
- Sumários e mensagens são exibidos no console

---

## 🔁 Reprodutibilidade

Use a opção `-s <seed>` ao gerar amostras com o comando `sample` para garantir que os resultados sejam sempre os mesmos em diferentes execuções.

---

## 🧪 Exemplo de fluxo completo

```bash
Rscript enem.R sample -f data/microdados.csv -p 1 -s 123
Rscript enem.R summary
Rscript enem.R anova -v NU_NOTA_CN,NU_NOTA_CH -c Q006
Rscript enem.R bp -v NU_NOTA_LC
```

---

## 👤 Autor(s)

Iuri Santana Goes da Silva


Desenvolvido para facilitar a análise exploratória de dados do ENEM por linha de comando.