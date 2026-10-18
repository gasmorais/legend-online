package yishi.datas.templates
{
   import manager.LanguageMgr;
   
   public class AppellInfoTemplate
   {
      
      public var TemplateId:int;
      
      public var Type:int;
      
      private var _Title:String = "";
      
      public var htmlTitle:String = "";
      
      public var Descript:String = "";
      
      public var Quality:int;
      
      public var Notice:Boolean;
      
      public var Perfix:String = "";
      
      public var Sort:int;
      
      public var IsLong:Boolean;
      
      public var IsTitleHide:int;
      
      public var CondtionType:int;
      
      public var Para:String;
      
      public var Job:int;
      
      public var ShowParam:String = "";
      
      public var Skills:String;
      
      public var Buffs:String;
      
      public var IsHide:int;
      
      private var _showOptions:Array;
      
      public var validDate:String = "2000-01-01 00:00:00";
      
      public var isGet:Boolean;
      
      public var isEquiped:Boolean;
      
      public var progress:String;
      
      public var Time:String;
      
      public var endTime:String;
      
      public function AppellInfoTemplate()
      {
         super();
      }
      
      public function get Title() : String
      {
         return _Title;
      }
      
      public function set Title(param1:String) : void
      {
         var _loc2_:RegExp = /\\n/g;
         _Title = param1.replace(_loc2_,"");
         htmlTitle = param1.replace(_loc2_,"\n");
      }
      
      public function get showOptions() : Array
      {
         if(!_showOptions)
         {
            _showOptions = ShowParam.split(",");
         }
         return _showOptions;
      }
      
      public function get ImgId() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get ImgWidth() : int
      {
         var _loc2_:int = 1;
         var _loc1_:int = 65;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get ImgHeight() : int
      {
         var _loc2_:int = 2;
         var _loc1_:int = 18;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get txtY() : int
      {
         var _loc2_:int = 3;
         var _loc1_:int = 0;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get fontSize() : int
      {
         var _loc2_:int = 4;
         var _loc1_:int = 16;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get colorId() : int
      {
         var _loc2_:int = 5;
         var _loc1_:int = 1;
         if(showOptions && _showOptions.length > 0 && showOptions[_loc2_] != 0)
         {
            _loc1_ = int(showOptions[_loc2_]);
         }
         if(_loc1_ <= 0)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      public function get ImgCount() : int
      {
         return 1;
      }
      
      public function get ImgFrame() : int
      {
         return 1;
      }
      
      public function getProgress() : String
      {
         var _loc6_:Array = null;
         var _loc3_:int = 0;
         var _loc8_:Array = null;
         var _loc7_:Array = null;
         var _loc9_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(!Para)
         {
            return "";
         }
         var _loc2_:Array = [];
         var _loc1_:Array = Para.split("|");
         if(progress)
         {
            _loc6_ = progress.split("|");
         }
         else
         {
            _loc6_ = [];
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(!_loc1_[_loc3_])
            {
               _loc2_.push("");
            }
            else
            {
               _loc8_ = _loc1_[_loc3_].split(",");
               _loc7_ = _loc6_[_loc3_] ? _loc6_[_loc3_].split(",") : [0];
               if(TemplateId == 65)
               {
                  _loc9_ = 0;
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_.length)
                  {
                     _loc4_ = _loc6_[_loc5_].split(",");
                     if(int(_loc4_[0]) >= int(_loc8_[0]))
                     {
                        _loc9_ += int(_loc4_[1]);
                     }
                     _loc5_++;
                  }
                  _loc7_[_loc7_.length - 1] = _loc9_;
               }
               _loc2_.push(LanguageMgr.GetTranslation("public.slash",_loc7_[_loc7_.length - 1],_loc8_[_loc8_.length - 1]));
            }
            _loc3_++;
         }
         return _loc2_.join(",");
      }
   }
}

