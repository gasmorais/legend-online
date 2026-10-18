package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class TheseusItemTip extends BaseTip
   {
      
      private var _txt:FilterFrameText;
      
      private var _hBox:HBox;
      
      public function TheseusItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 155;
         _bg.height = 240;
         _txt = ComponentFactory.Instance.creatComponentByStylename("skyStepTip.txt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("skyStepTip.hBox");
         addChild(_txt);
         addChild(_hBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:Array = null;
         if(tipData != null)
         {
            ObjectUtils.disposeAllChildren(_hBox);
            _hBox.beginChanges();
            _loc1_ = tipData.arr as Array;
            for each(var _loc3_:GoodsInfo in _loc1_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("skyStepTip.BaseItemView");
               _loc2_.data = _loc3_;
               _hBox.addChild(_loc2_);
            }
            _hBox.commitChanges();
            _bg.height = _hBox.y + _hBox.height + 10;
            _bg.width = Math.max(_txt.width,_hBox.width) + _hBox.x + 15;
            _txt.text = tipData.name;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

