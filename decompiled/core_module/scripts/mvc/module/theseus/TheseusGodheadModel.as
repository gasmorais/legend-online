package mvc.module.theseus
{
   import manager.LanguageMgr;
   import yishi.datas.templates.TheseusSlateInfo;
   import yishi.datas.templates.cate.TheseusSlateTaskCate;
   import yishi.manager.TempleteManager;
   
   public class TheseusGodheadModel
   {
      
      private var _bggrids:Array;
      
      private var _isInitialized:Boolean = false;
      
      private var _posMark:int = 0;
      
      private var _gridUnlockStatus:Array = [];
      
      private var _totalPropertyFromServer:Object;
      
      private var _equipedStoneInfo:Array = [];
      
      private var _attValues:Array = [];
      
      private var _attNames:Array = [];
      
      private var _isDecomposeVisible:Boolean = false;
      
      private var _isMainViewVisible:Boolean = true;
      
      private var _isRotateMode:Boolean = false;
      
      public var DecomposeList:Array = [];
      
      private var _slateTasks:Array = [];
      
      private var _completedTasks:Object;
      
      public function TheseusGodheadModel()
      {
         super();
         _bggrids = [];
         _posMark = 0;
         _totalPropertyFromServer = {};
         _slateTasks = [];
         _completedTasks = {};
      }
      
      public function initialize() : void
      {
         if(_isInitialized)
         {
            return;
         }
         _isInitialized = true;
         initSlateTasks();
      }
      
      public function get gridCount() : int
      {
         return 25;
      }
      
      public function getEquipedStoneInfo() : Array
      {
         return _equipedStoneInfo;
      }
      
      public function setPosMark(param1:int) : void
      {
         _posMark = param1;
      }
      
      public function isGridUnlocked(param1:int) : Boolean
      {
         if(param1 < 0 || param1 >= 25)
         {
            return false;
         }
         return (_posMark >> param1 & 1) != 1;
      }
      
      public function getGridUnlockStatus() : Array
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 25)
         {
            _gridUnlockStatus.push(isGridUnlocked(_loc1_));
            _loc1_++;
         }
         return _gridUnlockStatus;
      }
      
      public function getUnlockedGridCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _gridUnlockStatus.length)
         {
            if(isGridUnlocked(_loc2_))
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getBagStones() : Array
      {
         return _bggrids;
      }
      
      public function clearPag() : void
      {
         _bggrids = [];
      }
      
      public function setStoneToEquipPos(param1:int, param2:TheseusGodheadStoneInfo) : void
      {
         if(_equipedStoneInfo)
         {
            _equipedStoneInfo.push(param2);
         }
      }
      
      public function removeFromBag(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:TheseusGodheadStoneInfo = null;
         if(_bggrids)
         {
            _loc2_ = int(_bggrids.length);
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = _bggrids[_loc4_];
               if(_loc5_ && _loc5_.stoneId == param1)
               {
                  _loc3_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            _bggrids.splice(_loc3_,1);
         }
      }
      
      public function removeHasEquipedinfo(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:TheseusGodheadStoneInfo = null;
         if(_equipedStoneInfo)
         {
            _loc2_ = int(_equipedStoneInfo.length);
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = _equipedStoneInfo[_loc4_];
               if(_loc5_ && _loc5_.stoneId == param1)
               {
                  _loc3_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            _equipedStoneInfo.splice(_loc3_,1);
         }
      }
      
      public function getStoneById(param1:int) : TheseusGodheadStoneInfo
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TheseusGodheadStoneInfo = null;
         if(_equipedStoneInfo)
         {
            _loc2_ = int(_equipedStoneInfo.length);
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = _equipedStoneInfo[_loc5_];
               if(_loc6_ && _loc6_.stoneId == param1)
               {
                  return _loc6_;
               }
               _loc5_++;
            }
         }
         for each(var _loc3_:TheseusGodheadStoneInfo in _bggrids)
         {
            if(_loc3_.stoneId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function updateStoneById(param1:int, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:TheseusGodheadStoneInfo = null;
         _loc3_ = 0;
         while(_loc3_ < _equipedStoneInfo.length)
         {
            _loc4_ = _equipedStoneInfo[_loc3_] as TheseusGodheadStoneInfo;
            if(_loc4_ && _loc4_.stoneId == param1)
            {
               if(param2.hasOwnProperty("equipPos"))
               {
                  _loc4_.equipPos = param2.equipPos;
               }
               if(param2.hasOwnProperty("pos"))
               {
                  _loc4_.pos = param2.pos;
               }
            }
            _loc3_++;
         }
         var _loc5_:TheseusGodheadStoneInfo = getStoneById(param1);
         if(!_loc5_)
         {
            return false;
         }
         if(param2.hasOwnProperty("templateId"))
         {
            _loc5_.templateId = param2.templateId;
         }
         if(param2.hasOwnProperty("pos"))
         {
            _loc5_.pos = param2.pos;
         }
         if(param2.hasOwnProperty("level"))
         {
            _loc5_.level = param2.level;
         }
         if(param2.hasOwnProperty("star"))
         {
            _loc5_.star = param2.star;
            _loc5_.updateMaxLevel();
         }
         if(param2.hasOwnProperty("rotate"))
         {
            _loc5_.rotate = param2.rotate;
         }
         if(param2.hasOwnProperty("equipPos"))
         {
            _loc5_.equipPos = param2.equipPos;
         }
         if(param2.hasOwnProperty("isLock"))
         {
            _loc5_.isLock = param2.isLock;
         }
         if(param2.hasOwnProperty("isExist"))
         {
            _loc5_.isExist = param2.isExist;
         }
         if(param2.hasOwnProperty("baseAttributes"))
         {
            _loc5_.baseAttributes = param2.baseAttributes;
         }
         return true;
      }
      
      public function addStoneToBag(param1:TheseusGodheadStoneInfo) : void
      {
         if(param1)
         {
            _bggrids.push(param1);
         }
      }
      
      public function getPosByShapeandRotate(param1:TheseusGodheadStoneInfo, param2:int) : int
      {
         param2 = param2;
         var _loc4_:int = param1.shape;
         var _loc3_:int = param1.rotate;
         switch(param1.shape - 1)
         {
            case 0:
               if(_loc3_ == 0 || _loc3_ == 2)
               {
                  param2 -= 1;
               }
               else
               {
                  param2 -= 5;
               }
               break;
            case 1:
               if(_loc3_ == 3 || _loc3_ == 1)
               {
                  param2 -= 1;
               }
               else
               {
                  param2 -= 5;
               }
               break;
            case 2:
            case 4:
               if(_loc3_ == 1 || _loc3_ == 3)
               {
                  param2 -= 1;
                  break;
               }
               param2 -= 5;
               break;
            case 3:
            case 5:
            case 6:
               param2 = param2;
         }
         return param2;
      }
      
      public function set isDecomposeVisible(param1:Boolean) : void
      {
         _isDecomposeVisible = param1;
      }
      
      public function get isDecomposeVisible() : Boolean
      {
         return _isDecomposeVisible;
      }
      
      public function set isMainViewVisible(param1:Boolean) : void
      {
         _isMainViewVisible = param1;
      }
      
      public function get isMainViewVisible() : Boolean
      {
         return _isMainViewVisible;
      }
      
      public function set isRotateMode(param1:Boolean) : void
      {
         _isRotateMode = param1;
      }
      
      public function get isRotateMode() : Boolean
      {
         return _isRotateMode;
      }
      
      public function setTotalPropertyFromServer(param1:Object) : void
      {
         _totalPropertyFromServer = param1;
      }
      
      public function get attNames() : Array
      {
         if(!_totalPropertyFromServer)
         {
            return [];
         }
         _attValues.length = 0;
         _attNames.length = 0;
         if(_totalPropertyFromServer.attack > 0)
         {
            _attValues.push(_totalPropertyFromServer.attack);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText08"));
         }
         if(_totalPropertyFromServer.defence > 0)
         {
            _attValues.push(_totalPropertyFromServer.defence);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText09"));
         }
         if(_totalPropertyFromServer.magicAttack > 0)
         {
            _attValues.push(_totalPropertyFromServer.magicAttack);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText10"));
         }
         if(_totalPropertyFromServer.magicDefence > 0)
         {
            _attValues.push(_totalPropertyFromServer.magicDefence);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText11"));
         }
         if(_totalPropertyFromServer.forceHit > 0)
         {
            _attValues.push(_totalPropertyFromServer.forceHit);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText12"));
         }
         if(_totalPropertyFromServer.live > 0)
         {
            _attValues.push(_totalPropertyFromServer.live);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText15"));
         }
         if(_totalPropertyFromServer.parry > 0)
         {
            _attValues.push(_totalPropertyFromServer.parry);
            _attNames.push(LanguageMgr.GetTranslation("tips.ChildrenFigureTip.typeText14"));
         }
         if(_totalPropertyFromServer.penetrate > 0)
         {
            _attValues.push(_totalPropertyFromServer.penetrate);
            _attNames.push(LanguageMgr.GetTranslation("PropertyName.Penetrate"));
         }
         return _attNames;
      }
      
      public function get attValues() : Array
      {
         return _attValues;
      }
      
      public function getTotalPropertyFromServer() : Object
      {
         return _totalPropertyFromServer;
      }
      
      public function getAttributeSum(param1:String) : int
      {
         var _loc5_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:Array = getEquipedStoneInfo();
         for each(var _loc4_:TheseusGodheadStoneInfo in _loc3_)
         {
            _loc5_ = _loc4_.getTotalAttributes();
            if(_loc5_.hasOwnProperty(param1))
            {
               _loc2_ += _loc5_[param1];
            }
         }
         return _loc2_;
      }
      
      public function getTotalAttributes() : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Object = {};
         var _loc1_:Array = getEquipedStoneInfo();
         for each(var _loc5_:TheseusGodheadStoneInfo in _loc1_)
         {
            _loc3_ = _loc5_.getTotalAttributes();
            for(var _loc4_:String in _loc3_)
            {
               if(_loc2_.hasOwnProperty(_loc4_))
               {
                  var _loc6_:String = _loc4_;
                  var _loc7_:Number = _loc2_[_loc6_] + _loc3_[_loc4_];
                  _loc2_[_loc6_] = _loc7_;
               }
               else
               {
                  _loc2_[_loc4_] = _loc3_[_loc4_];
               }
            }
         }
         return _loc2_;
      }
      
      public function getNamebySlateType(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("theseusgodhead.txt17");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("theseusgodhead.txt18");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("theseusgodhead.txt19");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("theseusgodhead.txt20");
         }
         return _loc2_;
      }
      
      public function parseSlateAttributes(param1:Object, param2:String) : void
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(!param2 || param2.length == 0)
         {
            return;
         }
         var _loc7_:Array = param2.split("|");
         for each(var _loc5_:String in _loc7_)
         {
            _loc3_ = _loc5_.split(",");
            if(_loc3_.length != 2)
            {
               continue;
            }
            _loc6_ = parseInt(_loc3_[0]);
            _loc4_ = parseInt(_loc3_[1]);
            switch(_loc6_ - 1)
            {
               case 0:
                  param1["Attack"] = _loc4_;
                  break;
               case 1:
                  param1["Defence"] = _loc4_;
                  break;
               case 2:
                  param1["MagicAttack"] = _loc4_;
                  break;
               case 3:
                  param1["MagicDefence"] = _loc4_;
                  break;
               case 4:
                  param1["ForceHit"] = _loc4_;
                  break;
               case 5:
                  param1["Penetrate"] = _loc4_;
                  break;
               case 6:
                  param1["Parry"] = _loc4_;
                  break;
               case 7:
                  param1["Live"] = _loc4_;
            }
         }
      }
      
      private function initSlateTasks() : void
      {
         var _loc1_:TheseusSlateTaskCate = TempleteManager.instance.theseusSlateTaskCate;
         if(_loc1_)
         {
            _slateTasks = _loc1_.getAllSlateTaskTemplates();
            trace("加载了 " + _slateTasks.length + " 个石板任务模板");
         }
      }
      
      public function getSlateTasks() : Array
      {
         return _slateTasks;
      }
      
      public function setTaskStatus(param1:int, param2:int) : void
      {
         if(_completedTasks)
         {
            _completedTasks[param1] = param2;
         }
      }
      
      public function get compeltedTasks() : Object
      {
         return _completedTasks;
      }
      
      public function getStoneCountWithLevel(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TheseusGodheadStoneInfo = null;
         var _loc5_:int = 0;
         if(_equipedStoneInfo)
         {
            _loc3_ = int(_equipedStoneInfo.length);
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc8_ = _equipedStoneInfo[_loc7_];
               if(_loc8_ && _loc8_.isExist && _loc8_.level >= param1 && _loc8_.SlateType >= param2)
               {
                  _loc5_++;
               }
               _loc7_++;
            }
         }
         for each(var _loc4_:TheseusGodheadStoneInfo in _bggrids)
         {
            if(_loc4_ && _loc4_.isExist && _loc4_.level >= param1 && _loc4_.SlateType >= param2)
            {
               _loc5_++;
            }
         }
         return _loc5_;
      }
      
      public function getBagStoneCountByTemplateId(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:TheseusGodheadStoneInfo in _bggrids)
         {
            if(_loc4_ && _loc4_.isExist && _loc4_.templateId == param1)
            {
               if(_loc4_.stoneId != param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getStoneTemplate(param1:int) : TheseusSlateInfo
      {
         return TempleteManager.instance.theseusSlateCate.getSlateTemplate(param1);
      }
      
      public function getUpgradeTemplate(param1:int, param2:int) : Object
      {
         return TempleteManager.instance.theseusSlateCate.getSlateTemplate(param1);
      }
      
      public function get isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function canDragStone() : Boolean
      {
         if(_isDecomposeVisible)
         {
            return false;
         }
         if(!_isMainViewVisible)
         {
            return false;
         }
         if(_isRotateMode)
         {
            return false;
         }
         return true;
      }
   }
}

