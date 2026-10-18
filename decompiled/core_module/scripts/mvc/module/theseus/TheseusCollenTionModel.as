package mvc.module.theseus
{
   import com.road.yishi.proto.collection.CollectionDataMsg;
   import managers.PlayerCurrencyManager;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class TheseusCollenTionModel
   {
      
      public static const EVENT_TheseusCollenTion_BAG_UPDATE:String = "EVENT_TheseusCollenTion_BAG_UPDATE";
      
      public static const EVENT_TheseusBOX_BAG_UPDATE:String = "EVENT_TheseusBOX_BAG_UPDATE";
      
      public static const SELECT_TheseusBOX_CHANGE:String = "SELECT_TheseusBOX_CHANGE";
      
      public static const SELECT_TheseusshopBOX_CHANGE:String = "SELECT_TheseusshopBOX_CHANGE";
      
      public static const CollenTion_BAG_TYPE:int = 5;
      
      public static const Box_BAG_TYPE:int = 6;
      
      public var boxProcess:int;
      
      public var boxDropId:int;
      
      public var armorBagDic:SimpleDictionary;
      
      public var boxBagDic:SimpleDictionary;
      
      public var selectData:int = 0;
      
      public var color:Array = ["0x34a1f4","0xad38f8","0xff8100"];
      
      private var _selectBox:GoodsInfo;
      
      public var selectBoxindex:int;
      
      public var dorpArr:Array = [];
      
      public var myTotalScore:int;
      
      public var playerScoreRewardList:Array;
      
      public var myTotalid:int;
      
      public var allTotallevel:int;
      
      public var allred:Boolean;
      
      public var hasCollectionArray:Array = [];
      
      public var allCollectionArray:Array = [];
      
      public var allGoodCollectionArray:Array = [];
      
      private var _selectshopBox:GoodsInfo;
      
      public var selectshopBoxindex:int;
      
      private var _isrefresetDataBoo:Boolean = false;
      
      public function TheseusCollenTionModel()
      {
         super();
         armorBagDic = new SimpleDictionary();
         boxBagDic = new SimpleDictionary();
         if(!playerScoreRewardList)
         {
            playerScoreRewardList = [];
         }
      }
      
      public function setdorpArr() : void
      {
         var _loc1_:int = 0;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc3_];
            _loc1_ = _loc5_.Property1;
            _loc3_++;
         }
      }
      
      public function get selectBox() : GoodsInfo
      {
         return _selectBox;
      }
      
      public function set selectBox(param1:GoodsInfo) : void
      {
         _selectBox = param1;
         MsgMan.notifyObserver("SELECT_TheseusBOX_CHANGE");
      }
      
      public function get selectshopBox() : GoodsInfo
      {
         return _selectshopBox;
      }
      
      public function set selectshopBox(param1:GoodsInfo) : void
      {
         _selectshopBox = param1;
         MsgMan.notifyObserver("SELECT_TheseusshopBOX_CHANGE");
      }
      
      public function getallCollectionArray() : void
      {
         if(allGoodCollectionArray.length <= 0)
         {
            allGoodCollectionArray = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonTypeAndP2(2002);
         }
      }
      
      public function setupstarCollectionData(param1:Array, param2:Function = null) : void
      {
         var _loc4_:CollectionDataMsg = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < hasCollectionArray.length)
         {
            _loc4_ = hasCollectionArray[_loc3_];
            if(_loc4_.templateId == param1[0].templateId)
            {
               hasCollectionArray.splice(_loc3_,1);
               _loc3_--;
               break;
            }
            _loc3_++;
         }
         hasCollectionArray.push(param1[0]);
         _isrefresetDataBoo = true;
         if(param2 != null)
         {
            param2();
         }
      }
      
      public function setHasCollection() : void
      {
         var _loc1_:TheseusCollectionInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         getallCollectionArray();
         allCollectionArray = [];
         _loc2_ = 0;
         while(_loc2_ < allGoodCollectionArray.length)
         {
            _loc1_ = new TheseusCollectionInfo();
            _loc1_.templeteInfo = allGoodCollectionArray[_loc2_];
            _loc1_.Id = _loc1_.templeteInfo.TemplateId;
            _loc1_.star = 0;
            _loc1_.isPassive = false;
            _loc3_ = 0;
            while(_loc3_ < hasCollectionArray.length)
            {
               if(hasCollectionArray[_loc3_].templateId == allGoodCollectionArray[_loc2_].TemplateId)
               {
                  _loc1_.isPassive = true;
                  _loc1_.star = hasCollectionArray[_loc3_].star;
               }
               _loc3_++;
            }
            allCollectionArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function getSelectData(param1:int) : TheseusCollectionInfo
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < allCollectionArray.length)
         {
            if(allCollectionArray[_loc2_].templeteInfo.TemplateId == param1)
            {
               return allCollectionArray[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function suit(param1:String, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:Array = getSuit(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].star < param2 || !_loc3_[_loc4_].isPassive)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function getSuit(param1:String) : Array
      {
         var _loc6_:TheseusCollectionInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = param1.split("|");
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < allCollectionArray.length)
         {
            _loc6_ = allCollectionArray[_loc4_];
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               if(_loc6_.templeteInfo.TemplateId == _loc2_[_loc5_])
               {
                  _loc3_.push(_loc6_);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function byProGetCollection(param1:int, param2:Object = null) : Array
      {
         var _loc5_:TheseusCollectionInfo = null;
         var _loc4_:int = 0;
         if(_isrefresetDataBoo)
         {
            setHasCollection();
            _isrefresetDataBoo = false;
         }
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < allCollectionArray.length)
         {
            _loc5_ = allCollectionArray[_loc4_];
            if(_loc5_.templeteInfo.Profile == param1 + 2)
            {
               _loc3_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      public function checkAllcollectionRed() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < allCollectionArray.length)
         {
            if(checkRed(allCollectionArray[_loc1_].templeteInfo.TemplateId))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function checkAllboxRed() : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < boxBagDic.keys.length)
         {
            if(boxBagDic[boxBagDic.keys[_loc2_]].count > 0)
            {
               return true;
            }
            _loc2_++;
         }
         var _loc1_:int = PlayerCurrencyManager.instance.currencyInfo.theseuscollectionBox.amount;
         return boxProcess - _loc1_ <= 0;
      }
      
      public function checkRed(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:TheseusCollectionInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = gold.count;
         _loc3_ = 0;
         while(_loc3_ < allCollectionArray.length)
         {
            _loc6_ = allCollectionArray[_loc3_];
            if(_loc6_.starnextInfo && _loc6_.templeteInfo.TemplateId == param1 && _loc5_ >= _loc6_.starnextInfo.UpGold && byidGetNum(_loc6_.starnextInfo.chipId) >= _loc6_.starnextInfo.chipNeedNum)
            {
               if(_loc6_.starnextInfo.chipNeedNum1 <= 0)
               {
                  return true;
               }
               if(byidGetNum(_loc6_.starnextInfo.chipId1) >= _loc6_.starnextInfo.chipNeedNum1)
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function byidGetNum(param1:int) : int
      {
         for each(var _loc2_:GoodsInfo in armorBagDic)
         {
            if(_loc2_.templateInfo.TemplateId == param1)
            {
               return _loc2_.count;
            }
         }
         return 0;
      }
      
      public function getCurGradeAndMaxData(param1:int, param2:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:RavePartyRewardInfo = null;
         var _loc3_:int = int(param2.length);
         if(_loc3_ <= 0)
         {
            return [];
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            if(param1 < _loc5_.needValue)
            {
               return [_loc4_ + 1,_loc5_.needValue];
            }
            _loc4_++;
         }
         return [_loc3_,"max"];
      }
   }
}

