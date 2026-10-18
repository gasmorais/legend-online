package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.DragonTalkerSymbiotePropHelper;
   import dragontalker.item.DragonTalkerSymbioteItem;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class DragonTalkerSymbioteBagView extends Component
   {
      
      private var _back:Image;
      
      private var _itemContiner:Component;
      
      private var _propImage:MutipleImage;
      
      private var itemList:Vector.<DragonTalkerSymbioteItem>;
      
      private var itemPosArr:Array = [[125,15],[15,145],[15,250],[128,100],[250,145],[128,185]];
      
      public function DragonTalkerSymbioteBagView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0t.back");
         _itemContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteBagView.itemContiner");
         _propImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteBagView.propImage");
         addChild(_back);
         addChild(_itemContiner);
         addChild(_propImage);
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DragonTalkerSymbioteItem = null;
         itemList = new Vector.<DragonTalkerSymbioteItem>();
         var _loc2_:int = int(itemPosArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerSymbioteBagView.item");
            _loc1_.x = itemPosArr[_loc3_][0];
            _loc1_.y = itemPosArr[_loc3_][1];
            _itemContiner.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSymbioteHandler);
         MsgMan.addObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateSymbioteTipsHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSymbioteHandler);
         MsgMan.removeObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateSymbioteTipsHandler);
      }
      
      private function __updateSymbioteHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateSymbioteTipsHandler(param1:String, param2:Object) : void
      {
         resetSymbioteTips();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DragonTalkerSymbioteItem = null;
         var _loc2_:int = int(itemPosArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = itemList[_loc3_];
            _loc1_.index = _loc3_;
            _loc3_++;
         }
         resetSymbioteTips();
      }
      
      private function resetSymbioteTips() : void
      {
         var _loc5_:String = LanguageMgr.GetTranslation("DragonTalkerSymbioteBagView.propTips.heroTitle");
         var _loc3_:SimpleDictionary = DragonTalkerSymbiotePropHelper.talismanPropDic;
         for(var _loc6_:String in _loc3_)
         {
            _loc5_ += "\n" + LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc6_,_loc3_[_loc6_]);
         }
         if(_loc3_.getList().length <= 0)
         {
            _loc5_ += LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         }
         var _loc1_:String = LanguageMgr.GetTranslation("DragonTalkerSymbioteBagView.propTips.dragonTalkerTitle");
         var _loc4_:SimpleDictionary = DragonTalkerSymbiotePropHelper.heroEquipPropDic;
         for(var _loc2_:String in _loc4_)
         {
            _loc1_ += "\n" + LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc2_,_loc4_[_loc2_]);
         }
         if(_loc4_.getList().length <= 0)
         {
            _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         }
         _propImage.tipData = _loc1_ + "\n\n" + _loc5_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_itemContiner);
         _itemContiner = null;
         ObjectUtils.disposeObject(_propImage);
         _propImage = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

