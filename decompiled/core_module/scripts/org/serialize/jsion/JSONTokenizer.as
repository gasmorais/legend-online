package org.serialize.jsion
{
   public class JSONTokenizer
   {
      
      private var jsonString:String;
      
      private var loc:int;
      
      private var ch:String;
      
      public function JSONTokenizer(param1:String)
      {
         super();
         jsonString = param1;
         loc = 0;
         nextChar();
      }
      
      public function getNextToken() : JSONToken
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:JSONToken = new JSONToken();
         skipIgnored();
         switch(ch)
         {
            case "{":
               _loc4_.type = 1;
               _loc4_.value = "{";
               nextChar();
               break;
            case "}":
               _loc4_.type = 2;
               _loc4_.value = "}";
               nextChar();
               break;
            case "[":
               _loc4_.type = 3;
               _loc4_.value = "[";
               nextChar();
               break;
            case "]":
               _loc4_.type = 4;
               _loc4_.value = "]";
               nextChar();
               break;
            case ",":
               _loc4_.type = 0;
               _loc4_.value = ",";
               nextChar();
               break;
            case ":":
               _loc4_.type = 6;
               _loc4_.value = ":";
               nextChar();
               break;
            case "t":
            case "T":
               _loc1_ = "t" + nextChar() + nextChar() + nextChar();
               if(_loc1_ == "true")
               {
                  _loc4_.type = 7;
                  _loc4_.value = true;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'true\' but found " + _loc1_);
               }
               break;
            case "f":
            case "F":
               _loc3_ = "f" + nextChar() + nextChar() + nextChar() + nextChar();
               if(_loc3_ == "false")
               {
                  _loc4_.type = 8;
                  _loc4_.value = false;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'false\' but found " + _loc3_);
               }
               break;
            case "n":
               _loc2_ = "n" + nextChar() + nextChar() + nextChar();
               if(_loc2_ == "null")
               {
                  _loc4_.type = 9;
                  _loc4_.value = null;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'null\' but found " + _loc2_);
               }
               break;
            case "\"":
               _loc4_ = readString();
               break;
            default:
               if(isDigit(ch) || ch == "-")
               {
                  _loc4_ = readNumber();
               }
               else
               {
                  if(ch == "")
                  {
                     return null;
                  }
                  parseError("Unexpected " + ch + " encountered");
               }
         }
         return _loc4_;
      }
      
      private function readString() : JSONToken
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:JSONToken = new JSONToken();
         _loc4_.type = 10;
         var _loc1_:String = "";
         nextChar();
         while(ch != "\"" && ch != "")
         {
            if(ch == "\\")
            {
               nextChar();
               switch(ch)
               {
                  case "\"":
                     _loc1_ += "\"";
                     break;
                  case "/":
                     _loc1_ += "/";
                     break;
                  case "\\":
                     _loc1_ += "\\";
                     break;
                  case "b":
                     _loc1_ += "\b";
                     break;
                  case "f":
                     _loc1_ += "\f";
                     break;
                  case "n":
                     _loc1_ += "\n";
                     break;
                  case "r":
                     _loc1_ += "\r";
                     break;
                  case "t":
                     _loc1_ += "\t";
                     break;
                  case "u":
                     _loc2_ = "";
                     _loc3_ = 0;
                     while(_loc3_ < 4)
                     {
                        if(!isHexDigit(nextChar()))
                        {
                           parseError(" Excepted a hex digit, but found: " + ch);
                        }
                        _loc2_ += ch;
                        _loc3_++;
                     }
                     _loc1_ += String.fromCharCode(parseInt(_loc2_,16));
                     break;
                  default:
                     _loc1_ += "\\" + ch;
               }
            }
            else
            {
               _loc1_ += ch;
            }
            nextChar();
         }
         if(ch == "")
         {
            parseError("Unterminated string literal");
         }
         nextChar();
         _loc4_.value = _loc1_;
         return _loc4_;
      }
      
      private function readNumber() : JSONToken
      {
         var _loc3_:JSONToken = new JSONToken();
         _loc3_.type = 11;
         var _loc1_:String = "";
         if(ch == "-")
         {
            _loc1_ += "-";
            nextChar();
         }
         if(!isDigit(ch))
         {
            parseError("Expecting a digit");
         }
         if(ch == "0")
         {
            _loc1_ += ch;
            nextChar();
            if(isDigit(ch))
            {
               parseError("A digit cannot immediately follow 0");
            }
         }
         else
         {
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         if(ch == ".")
         {
            _loc1_ += ".";
            nextChar();
            if(!isDigit(ch))
            {
               parseError("Expecting a digit");
            }
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         if(ch == "e" || ch == "E")
         {
            _loc1_ += "e";
            nextChar();
            if(ch == "+" || ch == "-")
            {
               _loc1_ += ch;
               nextChar();
            }
            if(!isDigit(ch))
            {
               parseError("Scientific notation number needs exponent value");
            }
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         var _loc2_:Number = Number(_loc1_);
         if(isFinite(_loc2_) && !isNaN(_loc2_))
         {
            _loc3_.value = _loc2_;
            return _loc3_;
         }
         parseError("Number " + _loc2_ + " is not valid!");
         return null;
      }
      
      private function nextChar() : String
      {
         return ch = jsonString.charAt(loc++);
      }
      
      private function skipIgnored() : void
      {
         skipWhite();
         skipComments();
         skipWhite();
      }
      
      private function skipComments() : void
      {
         if(ch == "/")
         {
            nextChar();
            switch(ch)
            {
               case "/":
                  do
                  {
                     nextChar();
                  }
                  while(ch != "\n" && ch != "");
                  nextChar();
                  break;
               case "*":
                  nextChar();
                  while(true)
                  {
                     if(ch == "*")
                     {
                        nextChar();
                        if(ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        nextChar();
                     }
                     if(ch == "")
                     {
                        parseError("Multi-line comment not closed");
                     }
                  }
                  nextChar();
                  break;
               default:
                  parseError("Unexpected " + ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private function skipWhite() : void
      {
         while(isWhiteSpace(ch))
         {
            nextChar();
         }
      }
      
      private function isWhiteSpace(param1:String) : Boolean
      {
         return param1 == " " || param1 == "\t" || param1 == "\n";
      }
      
      private function isDigit(param1:String) : Boolean
      {
         return param1 >= "0" && param1 <= "9";
      }
      
      private function isHexDigit(param1:String) : Boolean
      {
         var _loc2_:String = param1.toUpperCase();
         return isDigit(param1) || _loc2_ >= "A" && _loc2_ <= "F";
      }
      
      public function parseError(param1:String) : void
      {
         throw new JSONParseError(param1,loc,jsonString);
      }
   }
}

