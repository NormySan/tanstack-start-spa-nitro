FROM oven/bun:1 AS build

WORKDIR /app

COPY package.json package.json
RUN bun install --frozen-lockfile

COPY . .
RUN bun run build

FROM oven/bun:1 AS runtime

COPY --from=build /app/apps/web/.output .

EXPOSE 3000

CMD ["bun", "run", "./server/index.mjs"]