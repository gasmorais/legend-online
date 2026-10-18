package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import monster.item.MonsterKitchenItem;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class MonsterKitchenFrame extends Frame
   {
      
      private var _itemBack:Image;
      
      private var _border:ScaleBitmapImage;
      
      private var _itemBox:VBox;
      
      private var itemList:Vector.<MonsterKitchenItem>;
      
      private var cook_count:int = 4;
      
      public function MonsterKitchenFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("MonsterKitchenFrame.title.text");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterMagicCircleFrame.itemBack");
         _border = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterMagicCircleFrame.border");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterMagicCircleFrame.itemBox");
         addToContent(_border);
         addToContent(_itemBack);
         addToContent(_itemBox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterKitchenItem = null;
         itemList = new Vector.<MonsterKitchenItem>();
         _loc2_ = 0;
         while(_loc2_ < cook_count)
         {
            _loc1_ = new MonsterKitchenItem();
            _itemBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MONSTER_COOK_CHANGE",this,__cookListChangeHandler);
         MsgMan.addObserver("MONSTER_USER_INFO_CHANGE",this,__cookListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MONSTER_COOK_CHANGE",this,__cookListChangeHandler);
         MsgMan.removeObserver("MONSTER_USER_INFO_CHANGE",this,__cookListChangeHandler);
      }
      
      private function __cookListChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterKitchenItem = null;
         var _loc3_:Array = model.cookDic.getList();
         _loc3_.sortOn("index",16);
         _loc2_ = 0;
         while(_loc2_ < cook_count)
         {
            _loc1_ = itemList[_loc2_];
            _loc1_.data = _loc3_.length > _loc2_ ? _loc3_[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

