package encoGold.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.EncoGoldManager;
   import mvc.module.encoGold.EncoGoldItemInfo;
   import mvc.module.encoGold.EncoGoldModel;
   import yishi.utils.DateFormatter;
   
   public class EncoGoldMsgView extends Sprite implements Disposeable
   {
      
      private var _itemVbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _itemList:Array = [];
      
      public function EncoGoldMsgView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("encoGold.scrollMsgPanel");
         _itemVbox = ComponentFactory.Instance.creatCustomObject("encoGold.msgVbox");
         addChild(_scrollPanel);
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_itemVbox,true);
         _scrollPanel.invalidateViewport();
      }
      
      public function creatList() : void
      {
         var _loc2_:EncoGoldMsgItemView = null;
         var _loc8_:EncoGoldItemInfo = null;
         var _loc6_:int = 0;
         disposeListItem();
         ObjectUtils.removeChildAllChildren(_itemVbox);
         _itemVbox.beginChanges();
         var _loc7_:Array = [];
         var _loc5_:Array = [];
         var _loc3_:int = int(model.allMsgList.length);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc8_ = model.allMsgList[_loc4_];
            _loc6_ = getDayType(_loc8_.dayStr);
            if(_loc6_ == 2)
            {
               _loc7_.push(_loc8_);
            }
            else if(_loc6_ == 3)
            {
               _loc5_.push(_loc8_);
            }
            _loc4_ += 1;
         }
         var _loc1_:Array = _loc7_.concat(_loc5_);
         _loc3_ = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new EncoGoldMsgItemView();
            _loc2_.info = _loc1_[_loc4_];
            _itemVbox.addChild(_loc2_);
            _loc4_ += 1;
         }
         _itemVbox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function getDayType(param1:String) : int
      {
         var _loc2_:EncoGoldItemInfo = model.dayMsgList[model.currentDay - 1];
         var _loc4_:Number = Number(DateFormatter.parse(_loc2_.dayStr,"YYYY-MM-DD").time);
         var _loc3_:Number = Number(DateFormatter.parse(param1,"YYYY-MM-DD").time);
         var _loc5_:int = 0;
         if(_loc4_ > _loc3_)
         {
            _loc5_ = 1;
         }
         else if(_loc4_ == _loc3_)
         {
            _loc5_ = 2;
         }
         else
         {
            _loc5_ = 3;
         }
         return _loc5_;
      }
      
      private function get model() : EncoGoldModel
      {
         return EncoGoldManager.instance.model;
      }
      
      private function disposeListItem() : void
      {
         var _loc1_:EncoGoldMsgItemView = null;
         var _loc2_:int = int(_itemList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_];
            _loc1_.dispose();
            _loc3_ += 1;
         }
         _itemList = [];
      }
      
      public function dispose() : void
      {
         disposeListItem();
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

