package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.christmas.SnowyMistMsg;
   import flash.display.Sprite;
   import mvc.module.christmas.ChristmasModel;
   import yishi.manager.ChristmasManager;
   
   public class ChristmasSnowymistItemView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _hBox:HBox;
      
      private var _data:SnowyMistMsg;
      
      public function ChristmasSnowymistItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistItemView.bg");
         _hBox = ComponentFactory.Instance.creatCustomObject("ChristmasSnowymistItemView.hBox");
         addChild(_bg);
         addChild(_hBox);
      }
      
      public function set data(param1:SnowyMistMsg) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChristmasSnowymistItem = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _hBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = new ChristmasSnowymistItem(_loc3_);
            _loc2_.data = _data;
            _hBox.addChild(_loc2_);
            _loc3_++;
         }
         _hBox.commitChanges();
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
      }
   }
}

