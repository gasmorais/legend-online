package yishi.datas.templates
{
   public class MountTemplate
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var Power:int;
      
      public var Intellect:int;
      
      public var Physique:int;
      
      public var Agility:int;
      
      public var ExpandLevel:int;
      
      private var _AvatarPath:String;
      
      public var _mountWingPath:String;
      
      public var MountType:int;
      
      public var NeedItemId:int;
      
      public var NeedTimeItemId:int;
      
      public var Description:String;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var NeedMountGrade:int;
      
      public var Speed:int = 0;
      
      public var SoulScore:int;
      
      public var Sort:int = 0;
      
      public var Area:int = 0;
      
      public var IsFly:int = 0;
      
      public var IsStand:int = 0;
      
      public var validity:int = 0;
      
      private var _StarAddition:String;
      
      private var _isBuyFly:Boolean;
      
      private var _hasEffectFoot:Boolean;
      
      public var starAddList:Array = [];
      
      public var maxStarGrade:int = 0;
      
      public var GradeType:int = 0;
      
      public function MountTemplate()
      {
         super();
      }
      
      public function get isBuyFly() : Boolean
      {
         return _isBuyFly;
      }
      
      public function set isBuyFly(param1:Boolean) : void
      {
         _isBuyFly = param1;
      }
      
      public function get AvatarPath() : String
      {
         return _AvatarPath;
      }
      
      public function set AvatarPath(param1:String) : void
      {
         var _loc2_:Array = param1.split("|");
         if(_loc2_.length > 1)
         {
            _AvatarPath = _loc2_[0];
            if(_loc2_[1] == "wing")
            {
               _mountWingPath = _loc2_[0];
            }
         }
         else
         {
            _AvatarPath = _loc2_[0];
            _mountWingPath = "";
         }
      }
      
      public function get StarAddition() : String
      {
         return _StarAddition;
      }
      
      public function get hasEffectFoot() : Boolean
      {
         _hasEffectFoot = false;
         if(TemplateId == 3008)
         {
            _hasEffectFoot = true;
         }
         return _hasEffectFoot;
      }
      
      public function set StarAddition(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _StarAddition = param1;
         starAddList.length = 0;
         if(param1)
         {
            _loc2_ = param1.split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               starAddList[_loc3_] = int(_loc2_[_loc3_]);
               _loc3_++;
            }
         }
         maxStarGrade = starAddList.length;
      }
      
      public function get useStandPose() : Boolean
      {
         var _loc1_:Boolean = false;
         if(IsStand == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

