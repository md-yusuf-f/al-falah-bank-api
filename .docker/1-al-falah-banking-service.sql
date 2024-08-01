-- Create users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    national_id VARCHAR(20) UNIQUE NOT NULL,
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    referral_code VARCHAR(20),
    preferred_language VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Change ownership of the users table to postgres
ALTER TABLE users OWNER TO postgres;

-- Create accounts table
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance NUMERIC(15, 2) DEFAULT 0.00,
    currency VARCHAR(10) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Change ownership of the accounts table to postgres
ALTER TABLE accounts OWNER TO postgres;

-- Create transactions table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    transaction_type VARCHAR(50) NOT NULL,
    amount NUMERIC(15, 2) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    status VARCHAR(20) DEFAULT 'Completed'
);

-- Change ownership of the transactions table to postgres
ALTER TABLE transactions OWNER TO postgres;

-- Create security_questions table
CREATE TABLE security_questions (
    question_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    question VARCHAR(255) NOT NULL,
    answer_hash VARCHAR(255) NOT NULL
);

-- Change ownership of the security_questions table to postgres
ALTER TABLE security_questions OWNER TO postgres;

-- Create loans table
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    loan_amount NUMERIC(15, 2) NOT NULL,
    interest_rate NUMERIC(5, 2) NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_term INT NOT NULL,
    monthly_payment NUMERIC(15, 2) NOT NULL,
    balance NUMERIC(15, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Change ownership of the loans table to postgres
ALTER TABLE loans OWNER TO postgres;

-- Create investment_products table
CREATE TABLE investment_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    minimum_investment NUMERIC(15, 2) NOT NULL,
    rate_of_return NUMERIC(5, 2) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Change ownership of the investment_products table to postgres
ALTER TABLE investment_products OWNER TO postgres;

-- Create user_investments table
CREATE TABLE user_investments (
    investment_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    product_id INT REFERENCES investment_products(product_id),
    amount NUMERIC(15, 2) NOT NULL,
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Change ownership of the user_investments table to postgres
ALTER TABLE user_investments OWNER TO postgres;

-- Create audit_logs table
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    action VARCHAR(255) NOT NULL,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    details TEXT
);

-- Change ownership of the audit_logs table to postgres
ALTER TABLE audit_logs OWNER TO postgres;

-- Create notifications table
CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    message VARCHAR(255) NOT NULL,
    read_status BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Change ownership of the notifications table to postgres
ALTER TABLE notifications OWNER TO postgres;

-- Create payments table
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    recipient_account VARCHAR(20) NOT NULL,
    amount NUMERIC(15, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Completed'
);

-- Change ownership of the payments table to postgres
ALTER TABLE payments OWNER TO postgres;
