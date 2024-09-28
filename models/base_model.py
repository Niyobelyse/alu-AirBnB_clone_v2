from sqlalchemy import Column, String, DateTime
from datetime import datetime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class BaseModel:
    id = Column(String(60), primary_key=True, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, nullable=False)

    def __init__(self, *args, **kwargs):
        """Initialize model"""
        if kwargs:
            for key, value in kwargs.items():
                if key != "__class__":
                    setattr(self, key, value)
            if not self.id:
                self.id = str(uuid.uuid4())
            self.created_at = datetime.utcnow()
            self.updated_at = datetime.utcnow()

    def save(self):
        """Save the object and update storage"""
        self.updated_at = datetime.utcnow()
        models.storage.new(self)
        models.storage.save()

    def delete(self):
        """Delete the object from storage"""
        models.storage.delete(self)

    def to_dict(self):
        """Return a dictionary representation of the model"""
        dict_repr = self.__dict__.copy()
        dict_repr.pop('_sa_instance_state', None)  # Remove SQLAlchemy state
        return dict_repr

