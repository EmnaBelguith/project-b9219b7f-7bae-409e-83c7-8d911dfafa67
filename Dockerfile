FROM python:3.10-slim-bullseye
WORKDIR /app
COPY . /app/
RUN pip install /app/talkshow-extended
RUN pip install flask gunicorn
EXPOSE 5000
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=talkshow-extended/talkshow/app.py
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "talkshow-extended.talkshow.app:create_app"]
RUN echo "--- Listing /app contents ---"
RUN ls -R /app
RUN echo "--- Verifying Python import ---"
RUN python <<EOF
import sys
sys.path.insert(0, '/app/talkshow-extended')
try:
    from talkshow.app import create_app
    print('create_app found and importable!')
except ImportError as e:
    print('ImportError: ' + str(e))
    sys.exit(1)

EOF
RUN echo "--- Python import check complete ---"