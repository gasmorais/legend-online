package mvc.module.archeology
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.ArchaeologyBookTemplate;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ArchaeologyModel
   {
      
      public static const COMMON_MAPID:int = 0;
      
      public var exp:int;
      
      public var hasExplorationCount:int;
      
      public var hasBuyExplorCount:int;
      
      public var goodsArr:Array;
      
      public var handBookStateArr:Array;
      
      private var mapArr:Array;
      
      private var _selectItemInfo:ArchaeologyItemInfo;
      
      public var selectedDic:Dictionary;
      
      public var selectedType:int;
      
      public var typeBtnArr:Array = [0,0,0,0];
      
      public var outerBtnState:int = 0;
      
      public function ArchaeologyModel()
      {
         super();
         goodsArr = [];
         handBookStateArr = [];
         mapArr = [];
         selectedDic = new Dictionary();
      }
      
      public function checkHandBookStateById(param1:int) : int
      {
         var _loc2_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc6_:ArchaeologyHandBookInfo = getHandBookInfoById(param1);
         var _loc5_:ArchaeologyBookTemplate = TempleteManager.instance.archaeologyBookTemplateCate.getTemplateByID(param1);
         if(!_loc5_)
         {
            return 0;
         }
         if(_loc6_ && _loc6_.isGet)
         {
            return 3;
         }
         _loc2_ = getGoodItemStateById(_loc5_.Collection1) == 1 ? true : false;
         _loc4_ = getGoodItemStateById(_loc5_.Collection2) == 1 ? true : false;
         _loc3_ = getGoodItemStateById(_loc5_.Collection3) == 1 ? true : false;
         if(_loc2_ && _loc4_ && _loc3_)
         {
            return 1;
         }
         return 2;
      }
      
      public function getGoodItemStateById(param1:int) : int
      {
         if(param1 == 0)
         {
            return 1;
         }
         var _loc2_:ArchaeologyItemInfo = getItemInfoById(param1);
         if(_loc2_ && _loc2_.itemCount >= 1)
         {
            return 1;
         }
         return 2;
      }
      
      public function getHandBookInfoById(param1:int) : ArchaeologyHandBookInfo
      {
         for each(var _loc2_:ArchaeologyHandBookInfo in handBookStateArr)
         {
            if(_loc2_.tempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getItemInfoById(param1:int) : ArchaeologyItemInfo
      {
         for each(var _loc2_:ArchaeologyItemInfo in goodsArr)
         {
            if(_loc2_.tempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getGradeByExp(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(111);
         if(!_loc5_)
         {
            return _loc3_;
         }
         var _loc2_:int = int(_loc5_.length);
         _loc4_ = 1;
         while(_loc4_ < _loc2_)
         {
            if(param1 < _loc5_[_loc4_].Data)
            {
               return _loc4_;
            }
            param1 -= _loc5_[_loc4_].Data;
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getMapArr() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         mapArr.length = 0;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc1_ = {};
            _loc1_.mapId = _loc2_;
            _loc1_.mapName = LanguageMgr.GetTranslation("archaeology.mapArea.mapName" + _loc2_);
            mapArr.push(_loc1_);
            _loc2_++;
         }
         return mapArr;
      }
      
      public function getGoodsListByMapAndType(param1:int, param2:int) : Array
      {
         var _loc3_:Dictionary = TempleteManager.instance.archaeologyItemTemplateCate.getTemplates();
         var _loc5_:Array = [];
         for each(var _loc4_:ArchaeologyItemTemplate in _loc3_)
         {
            if(_loc4_ && _loc4_.Type == param2)
            {
               if(_loc4_.MapId == param1)
               {
                  _loc5_.push(_loc4_);
               }
            }
         }
         _loc5_.sortOn("Id",16);
         return _loc5_;
      }
      
      public function getGoodsListByMapId(param1:int) : Array
      {
         var _loc2_:Dictionary = TempleteManager.instance.archaeologyItemTemplateCate.getTemplates();
         var _loc4_:Array = [];
         for each(var _loc3_:ArchaeologyItemTemplate in _loc2_)
         {
            if(_loc3_ && _loc3_.MapId == param1)
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc4_.sortOn("Id",16);
         return _loc4_;
      }
      
      public function getAllGoodsDic() : Dictionary
      {
         return TempleteManager.instance.archaeologyItemTemplateCate.getTemplates();
      }
      
      public function getFirstInfoByMapId(param1:int) : ArchaeologyItemInfo
      {
         var _loc3_:ArchaeologyItemInfo = null;
         var _loc2_:Array = getGoodsListByMapId(param1);
         _loc2_.sortOn(["Type","Id"],[16,16]);
         if(_loc2_[0])
         {
            if(getItemInfoById(_loc2_[0].Id))
            {
               _loc3_ = getItemInfoById(_loc2_[0].Id);
               _loc3_.selected = true;
            }
            else
            {
               _loc3_ = new ArchaeologyItemInfo();
               _loc3_.tempId = _loc2_[0].Id;
               _loc3_.chipCount = 0;
               _loc3_.canMakeCount = 0;
               _loc3_.cellType = 2;
               _loc3_.groupId = _loc2_[0].Type;
               _loc3_.selected = true;
            }
         }
         return _loc3_;
      }
      
      public function getFirstInfoByMapIdAndType(param1:int, param2:int) : ArchaeologyItemInfo
      {
         var _loc4_:ArchaeologyItemInfo = null;
         var _loc3_:Array = getGoodsListByMapAndType(param1,param2);
         _loc3_.sortOn("Id",16);
         if(_loc3_[0])
         {
            if(getItemInfoById(_loc3_[0].Id))
            {
               _loc4_ = getItemInfoById(_loc3_[0].Id);
               _loc4_.selected = true;
            }
            else
            {
               _loc4_ = new ArchaeologyItemInfo();
               _loc4_.tempId = _loc3_[0].Id;
               _loc4_.chipCount = 0;
               _loc4_.canMakeCount = 0;
               _loc4_.cellType = 2;
               _loc4_.groupId = _loc3_[0].Type;
               _loc4_.selected = true;
            }
         }
         return _loc4_;
      }
      
      public function getBookArr() : Array
      {
         var _loc1_:Dictionary = TempleteManager.instance.archaeologyBookTemplateCate.getTemplates();
         var _loc3_:Array = [];
         for each(var _loc2_:ArchaeologyBookTemplate in _loc1_)
         {
            if(_loc2_.Type == 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sort(sortByState);
         return _loc3_;
      }
      
      private function sortByState(param1:ArchaeologyBookTemplate, param2:ArchaeologyBookTemplate) : int
      {
         var _loc4_:int = checkHandBookStateById(param1.Id);
         var _loc3_:int = checkHandBookStateById(param2.Id);
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(param1.Id < param2.Id)
         {
            return -1;
         }
         return 1;
      }
      
      public function getGradeRewardArr() : Array
      {
         var _loc1_:Dictionary = TempleteManager.instance.archaeologyBookTemplateCate.getTemplates();
         var _loc3_:Array = [];
         for each(var _loc2_:ArchaeologyBookTemplate in _loc1_)
         {
            if(_loc2_.Type == 2)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("Id",16);
         return _loc3_;
      }
      
      public function getGradeRewardByLevel(param1:int) : ArchaeologyBookTemplate
      {
         for each(var _loc2_:ArchaeologyBookTemplate in getGradeRewardArr())
         {
            if(_loc2_.Collection1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selectItemInfo() : ArchaeologyItemInfo
      {
         return _selectItemInfo;
      }
      
      public function set selectItemInfo(param1:ArchaeologyItemInfo) : void
      {
         if(_selectItemInfo == param1)
         {
            return;
         }
         _selectItemInfo = param1;
         if(_selectItemInfo)
         {
            selectedDic[selectedType + "_" + _selectItemInfo.groupId] = param1;
         }
         MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",_selectItemInfo);
      }
      
      public function getBookCanComposeCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:Dictionary = TempleteManager.instance.archaeologyBookTemplateCate.getTemplates();
         for each(var _loc3_:ArchaeologyBookTemplate in _loc1_)
         {
            if(_loc3_.Type == 1 && checkHandBookStateById(_loc3_.Id) == 1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getTypeBtnCanComposeCount() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = null;
         var _loc5_:ArchaeologyItemInfo = null;
         typeBtnArr = [0,0,0,0,0,0];
         _loc3_ = 0;
         while(_loc3_ <= 5)
         {
            _loc4_ = 1;
            while(_loc4_ <= 4)
            {
               _loc1_ = getGoodsListByMapAndType(_loc3_,_loc4_);
               for each(var _loc2_:ArchaeologyItemTemplate in _loc1_)
               {
                  _loc5_ = getItemInfoById(_loc2_.Id);
                  if(_loc5_)
                  {
                     if(int(_loc5_.chipCount / _loc2_.NeedChip) > 0)
                     {
                        typeBtnArr[_loc3_]++;
                        break;
                     }
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function getArchaeologyBtnTotalCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < typeBtnArr.length)
         {
            if(typeBtnArr[_loc2_] != 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(getBookCanComposeCount() > 0)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

