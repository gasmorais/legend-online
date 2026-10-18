package mvc.module.theseus
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.TheseusSlateInfo;
   import yishi.datas.templates.TheseusSlateUpgradeInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusGodheadStoneInfo
   {
      
      public var stoneId:int;
      
      public var templateId:int;
      
      public var name:String;
      
      public var pos:int;
      
      public var level:int;
      
      public var star:int;
      
      public var quality:int;
      
      public var icon:String;
      
      public var description:String;
      
      public var rotate:int;
      
      public var equipPos:int;
      
      public var isLock:Boolean;
      
      public var isExist:Boolean;
      
      public var isPlaceholder:Boolean;
      
      public var baseAttributes:Object;
      
      public var levelUpAttributes:Object;
      
      public var upgradeExp:int;
      
      public var starUpMaterials:Array;
      
      public var maxLevel:int;
      
      public var maxStar:int;
      
      public var type:int;
      
      public var subType:int;
      
      public var shape:int = 1;
      
      public var color:int;
      
      public function TheseusGodheadStoneInfo()
      {
         super();
         baseAttributes = {};
         levelUpAttributes = {};
         starUpMaterials = [];
         maxLevel = 10;
         maxStar = 5;
         quality = 1;
         type = 1;
         subType = 0;
         shape = 1;
         color = 1;
         upgradeExp = 0;
         isLock = false;
         isExist = true;
         rotate = 0;
         pos = -1;
         equipPos = -1;
      }
      
      public function get SlateDecomposition() : String
      {
         var _loc1_:TheseusSlateInfo = TempleteManager.instance.theseusSlateCate.getSlateTemplate(templateId);
         if(_loc1_)
         {
            return _loc1_.SlateDecomposition;
         }
         return "30000|1";
      }
      
      public function get SlateType() : int
      {
         var _loc1_:TheseusSlateInfo = TempleteManager.instance.theseusSlateCate.getSlateTemplate(templateId);
         if(_loc1_)
         {
            return _loc1_.SlateType;
         }
         return 1;
      }
      
      public function get SkillID() : Array
      {
         var _loc3_:String = null;
         var _loc2_:* = null;
         var _loc1_:TheseusSlateInfo = TempleteManager.instance.theseusSlateCate.getSlateTemplate(templateId);
         if(_loc1_)
         {
            _loc3_ = _loc1_.SlateSkillTemplate;
            return _loc3_.split(",");
         }
         return [];
      }
      
      public function clone() : TheseusGodheadStoneInfo
      {
         var _loc2_:TheseusGodheadStoneInfo = new TheseusGodheadStoneInfo();
         _loc2_.stoneId = this.stoneId;
         _loc2_.templateId = this.templateId;
         _loc2_.name = this.name;
         _loc2_.pos = this.pos;
         _loc2_.level = this.level;
         _loc2_.star = this.star;
         _loc2_.quality = this.quality;
         _loc2_.icon = this.icon;
         _loc2_.description = this.description;
         _loc2_.rotate = this.rotate;
         _loc2_.equipPos = this.equipPos;
         _loc2_.isLock = this.isLock;
         _loc2_.isExist = this.isExist;
         _loc2_.type = this.type;
         _loc2_.subType = this.subType;
         _loc2_.shape = this.shape;
         _loc2_.color = this.color;
         _loc2_.upgradeExp = this.upgradeExp;
         _loc2_.maxLevel = this.maxLevel;
         _loc2_.maxStar = this.maxStar;
         for(var _loc4_:String in this.baseAttributes)
         {
            _loc2_.baseAttributes[_loc4_] = this.baseAttributes[_loc4_];
         }
         for(var _loc3_:String in this.levelUpAttributes)
         {
            _loc2_.levelUpAttributes[_loc3_] = this.levelUpAttributes[_loc3_];
         }
         for each(var _loc1_:Object in this.starUpMaterials)
         {
            _loc2_.starUpMaterials.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getLevelAttributes(param1:int = -1) : Object
      {
         var _loc2_:int = 0;
         if(param1 == -1)
         {
            param1 = this.level;
         }
         var _loc3_:Object = {};
         for(var _loc4_:String in this.levelUpAttributes)
         {
            _loc2_ = int(this.levelUpAttributes[_loc4_]);
            _loc3_[_loc4_] = _loc2_ * param1;
         }
         return _loc3_;
      }
      
      public function getTotalAttributes() : Object
      {
         var _loc1_:Object = {};
         for(var _loc2_:String in baseAttributes)
         {
            _loc1_[_loc2_] = baseAttributes[_loc2_];
         }
         var _loc3_:Object = getLevelAttributes();
         for(_loc2_ in _loc3_)
         {
            if(_loc1_.hasOwnProperty(_loc2_))
            {
               var _loc5_:String = _loc2_;
               var _loc4_:Number = _loc1_[_loc5_] + _loc3_[_loc2_];
               _loc1_[_loc5_] = _loc4_;
            }
            else
            {
               _loc1_[_loc2_] = _loc3_[_loc2_];
            }
         }
         return _loc1_;
      }
      
      public function updateMaxLevel() : void
      {
         maxLevel = star * 10 + 10;
      }
      
      public function getStarUpMaterials(param1:int) : Array
      {
         if(param1 <= this.star)
         {
            return [];
         }
         var _loc2_:Array = [];
         var _loc3_:TempleteManager = TempleteManager.instance;
         for each(var _loc4_:ComposeGoodsTemplete in _loc3_.getComposeTempleteList())
         {
            if(_loc4_.Types == 370)
            {
               if(_loc4_.Material1 == this.templateId)
               {
                  if(_loc4_.Material2 > 0 && _loc4_.Count2 > 0)
                  {
                     _loc2_.push({
                        "itemId":_loc4_.Material2,
                        "count":_loc4_.Count2,
                        "newStoneid":_loc4_.NewMaterial
                     });
                  }
                  if(_loc4_.Material3 > 0 && _loc4_.Count3 > 0)
                  {
                     _loc2_.push({
                        "itemId":_loc4_.Material3,
                        "count":_loc4_.Count3,
                        "newStoneid":_loc4_.NewMaterial
                     });
                  }
                  break;
               }
            }
         }
         if(_loc2_.length == 0)
         {
            _loc2_ = starUpMaterials;
         }
         _loc3_ = null;
         return _loc2_;
      }
      
      public function canUpgrade(param1:int) : Boolean
      {
         return this.level < maxLevel && param1 <= maxLevel && param1 > this.level;
      }
      
      public function checkUpgradeCondition(param1:int, param2:Array) : Boolean
      {
         if(!canUpgrade(param1))
         {
            return false;
         }
         return true;
      }
      
      public function checkStarUpCondition(param1:int, param2:Array) : Boolean
      {
         return true;
      }
      
      public function serialize() : Object
      {
         return {
            "stoneId":stoneId,
            "templateId":templateId,
            "name":name,
            "pos":pos,
            "level":level,
            "star":star,
            "quality":quality,
            "icon":icon,
            "rotate":rotate,
            "equipPos":equipPos,
            "isLock":isLock,
            "isExist":isExist,
            "type":type,
            "subType":subType,
            "shape":shape,
            "color":color,
            "baseAttributes":baseAttributes
         };
      }
      
      public function deserialize(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         stoneId = param1.stoneId || 0;
         templateId = param1.templateId || 0;
         name = param1.name || "";
         pos = param1.pos || -1;
         level = param1.level || 0;
         star = param1.star || 0;
         quality = param1.quality || 1;
         icon = param1.icon || "";
         rotate = param1.rotate || 0;
         equipPos = param1.equipPos || -1;
         isLock = param1.isLock;
         isExist = param1.isExist || true;
         type = param1.type || 1;
         subType = param1.subType || 0;
         shape = param1.shape || 0;
         color = param1.color || 1;
         if(param1.baseAttributes)
         {
            for(var _loc2_:String in param1.baseAttributes)
            {
               baseAttributes[_loc2_] = param1.baseAttributes[_loc2_];
            }
         }
      }
      
      public function getQualityColor() : uint
      {
         switch(quality - 1)
         {
            case 0:
               return 16777215;
            case 1:
               return 65280;
            case 2:
               return 255;
            case 3:
               return 16711935;
            case 4:
               return 16753920;
            default:
               return 16777215;
         }
      }
      
      public function compareTo(param1:TheseusGodheadStoneInfo) : int
      {
         if(!param1)
         {
            return 1;
         }
         if(this.star > param1.star)
         {
            return 1;
         }
         if(this.star < param1.star)
         {
            return -1;
         }
         if(this.level > param1.level)
         {
            return 1;
         }
         if(this.level < param1.level)
         {
            return -1;
         }
         if(this.quality > param1.quality)
         {
            return 1;
         }
         if(this.quality < param1.quality)
         {
            return -1;
         }
         return 0;
      }
      
      public function getUpgradeTemplateInfo(param1:int = -1) : TheseusSlateUpgradeInfo
      {
         if(param1 == -1)
         {
            param1 = this.level + 1;
         }
         if(templateId <= 0)
         {
            return null;
         }
         var _loc2_:TheseusSlateUpgradeCate = TempleteManager.instance.theseusSlateUpgradeCate;
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.getUpgradeTemplate(quality,param1,type);
      }
      
      public function getStarUpComposeTemplate(param1:int = -1) : ComposeGoodsTemplete
      {
         if(param1 == -1)
         {
            param1 = this.star + 1;
         }
         if(templateId <= 0)
         {
            return null;
         }
         var _loc2_:Dictionary = TempleteManager.instance.getComposeTempleteList();
         if(!_loc2_)
         {
            return null;
         }
         for each(var _loc3_:ComposeGoodsTemplete in _loc2_)
         {
            if(_loc3_.Types == 370 && _loc3_.Material1 == templateId)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function update(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         for(var _loc2_:String in param1)
         {
            if(this.hasOwnProperty(_loc2_))
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function clear() : void
      {
         stoneId = 0;
         templateId = 0;
         name = "";
         pos = -1;
         level = 0;
         star = 0;
         quality = 1;
         icon = "";
         description = "";
         rotate = 0;
         equipPos = -1;
         isLock = false;
         isExist = true;
         type = 1;
         subType = 0;
         shape = 0;
         color = 1;
         upgradeExp = 0;
         baseAttributes = {};
         starUpMaterials = [];
      }
   }
}

