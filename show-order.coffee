# Show Order Generator
# Luke Tsekouras
# luke.tsekouras@gmail.com

crypto = require 'crypto'

items = [
    name: '169'
    actors:
        'Henry Nguyen': before: 5
        'Nevin Lazarus': before: 5
        'Sylvia Chin': before: 5
,
    name: 'A Preset Occurrence'
    actors:
        'Nicola Sentinella': before: 5
        'Sylvia Chin': before: 5
        'Pierre Estephan': before: 5
        'Caroline Cham': before: 5
        'Octavia Soegyono': before: 5
,
    name: 'An Awkward Purchase'
    actors:
        'Caroline Cham': before: 5
        'Pierre Estephan': before: 5
        'Nafiul Haque': before: 5
,
    name: 'Antiques Roadshow'
    actors:
        'Alex Worsley': before: 5
        'Ben Pinto': before: 5
        'Lucas Pickup': before: 5
        'Yingran Sun': before: 5
,
    name: 'Bro'
    actors:
        'Henry Nguyen': before: 5
        'Nafiul Haque': before: 5
,
    name: 'Death Star Budget'
    actors:
        'Octavia Soegyono': before: 5
        'Vincent Tran': before: 5
        'Ben Pinto': before: 5
,
    name: 'Disk Jock'
    actors:
        'Louis Sammuels': before: 5
        'Henry Nguyen': before: 5
,
    name: 'Fourth Wall'
    actors:
        'Sherman Du': before: 5
        'Vinbob Tran': before: 5
,
    name: 'Frape'
    actors:
        'Raj Kapoor': before: 5
        'Ben Pinto': before: 5
        'Nevin Lazarus': before: 5
,
    name: 'Girl\'s Night Out'
    actors:
        'Yingran Sun': before: 5
        'Kitty Lee': before: 5
        'Sherman Du': before: 5
        'Daniel Lyons': before: 5
,
    name: 'Grandma in the way'
    actors:
        'Emmanuel Berkowicz': before: 5
        'Nicola Sentinella': before: 5
        'Emily Webster': before: 5
,
    name: 'HECS Games'
    actors:
        'Vanessa Ung': before: 5
        'Daniel Lyons': before: 5
,
    name: 'I\'d like to return my kid'
    actors:
        'Michael Nam Lee': before: 5
        'Emily Webster': before: 5
,
    name: 'Love in the time of Coding'
    actors:
        'Michael Nam Lee': before: 5
        'Kitty Lee': before: 5
        'Christina Truong': before: 5
,
    name: 'Modern Commandments'
    actors:
        'Sherman Du': before: 5
        'Vincent Tran': before: 5
,
    name: 'Princess Missing'
    actors:
        'Vanessa Ung': before: 5
        'Louis Sammuels': before: 5
        'Raj Kapoor': before: 5
        'Daniel Lyons': before: 5
        'Andrew Ha': before: 5
,
    name: 'Rock and a Hard Place'
    actors:
        'Alex Worsley': before: 5
        'Michael Nam Lee': before: 5
        'Sylvia Chin': before: 5
,
    name: 'Second-hand Salesman'
    actors:
        'Daniel Lyons': before: 5
        'Henry Nguyen': before: 5
        'Yingran Sun': before: 5
        'Omair Ali': before: 5
        'Vanessa Ung': before: 5
        'Michael Nam Lee': before: 5
,
    name: 'Sunday School'
    actors:
        'Holly Shuttleworth': before: 5
        'Vincent Tran': before: 5
        'Andrew Ha': before: 5
,
    name: 'Terra Nullius'
    actors:
        'Nevin Lazarus': before: 5
        'Christina Truong': before: 5
,
    name: 'That Poor Kitty'
    actors:
        'Kitty Lee': before: 5
        'Nafiul Haque': before: 5
        'Omair Ali': before: 5
        'Vincent Tran': before: 5
,
    name: 'The Leak'
    actors:
        'Emmanuel Berkowicz': before: 5
        'Caroline Cham': before: 5
,
    name: 'The Macabre Family'
    actors:
        'Lucas Pickup': before: 5
        'Nicola Sentinella': before: 5
,
    name: 'Under Construction'
    actors:
        'Lucas Pickup': before: 5
        'Rhi Gordon': before: 5
        'Nevin Lazarus': before: 5
        'Vinbob Tran': before: 5
,
    name: 'Would You Kindly'
    actors:
        'Emily Webster': before: 5
        'Alex Worsley': before: 5
        'Omair Ali': before: 5
        'Sylvia Chin': before: 5
,
    name: 'Happy'
    actors:
        'Nicola Sentinella': before: 2
        'Sherman Du': before: 2
        'Vincent Tran': before: 2
        'Caroline Cham': before: 2
        'Vanessa Ung': before: 2
,
    name: 'Africa'
    actors:
        'Yingran Sun': before: 2
        'Kitty Lee': before: 2
        'Octavia Soegyono': before: 2
        'Rhi Gordon': before: 2
        'Holly Shuttleworth': before: 2
        'Emily Webster': before: 2
        'Pierre Estephan': before: 2
        'Vinbob Tran': before: 2
,
    name: 'Consumer'
    actors:
        'Matthew McEwen': before: 2
        'Daniel Lyons': before: 2
        'Henry Nguyen': before: 2
        'Nafiul Haque': before: 2
        'Christina Truong': before: 2
        'Octavia Soegyono': before: 2
        'Sylvia Chin Rhi Gordon': before: 2
]

# 'Z5MYqhbtTKvqgFZzGK27Aw==' 397
# 'AzplBG3QfFtapOuCRTIp9g==' 397
# 'cwfAhsosizuNVzzomyv15A==' 398

Array.prototype.clone = -> @slice 0
is_in_item = (person, item) -> item.actors[person]?
random_int = (from, to) -> Math.floor Math.random() * (to - from + 1) + from
random_choice = (list) -> list[Math.floor(Math.random() * list.length)]

hash_object = (object) ->
    string = JSON.stringify(object)
    return crypto.createHash('md5').update(string).digest('base64')

evaluators =

    actors: (item, order, order_index) ->

        score = 0

        for name, prep_time of item.actors

            before_index = order_index - 1
            before_index-- while before_index >= 0 and not is_in_item(name, order[before_index])
            before = order_index - before_index - 1

            after_index = order_index + 1
            after_index++ while after_index < order.length and not is_in_item(name, order[after_index])
            after = after_index - order_index - 1

            score += Math.min before, prep_time.before ? 0
            score += Math.min after, prep_time.after ? 0

        return score

mutators = 

    shift: (order) ->

        size = random_int 2, order.length
        from = random_int 0, order.length - size
        shift = random_int 1, size - 1

        left = from
        right = from + size
        mid = left + shift

        # This is returned automatically as an array

        for a in [0...order.length]

            if a >= left and a < right
                if a < mid
                    a += right - mid
                else
                    a += left - mid

            order[a]

mutator_list = (mutator for name, mutator of mutators)

evaluate = (order) ->

    score = 0

    for name, evaluator of evaluators
        for item, index in order
            score += evaluator(item, order, index)

    return score

acceptance = (current_score, new_score, temperature) ->
    return current_score < new_score or Math.random() < Math.exp((new_score - 1 - current_score)/temperature)

store_order = (bests, order, score) ->
    bests[hash_object(order)] =
        order: order
        score: score

# Simulated annealing

order = items.clone()
score = evaluate(order)

starting_temperature = 10000
cooling_factor = 0.95
repetitions = 100
bests = {}

# How confident do we want to be that we've got an absolute local maximum?
completion_confidence = 0.5
completion_patience = Math.log(1 - completion_confidence) / Math.log(1 - 1/4495)

console.log 'completion_patience', completion_patience, order.length

for repetition in [1..repetitions]

    console.log 'repetition', repetition

    temperature = starting_temperature
    no_progress_count = 0

    while no_progress_count < completion_patience

        new_order = random_choice(mutator_list)(order)
        new_score = evaluate(new_order)

        if acceptance(score, new_score, temperature)
            no_progress_count = 0
            order = new_order
            score = new_score
        else
            no_progress_count++

        temperature *= cooling_factor

    console.log 'Score:', score, 'Temp:', temperature

    store_order(bests, order, score)

best_ranked = (order for hash, order of bests).sort (a, b) -> a.score - b.score

for order_score in best_ranked
    console.log order_score.order, hash_object(order_score.order), order_score.score