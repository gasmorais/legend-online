package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.BoxItemTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class MultipleGoodsTip extends BaseTip
   {
      
      private var _vbox:VBox;
      
      public function MultipleGoodsTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _vbox = ComponentFactory.Instance.creatComponentByStylename("tip.MultipleGoodsTips.vbox");
         addChild(_vbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc2_:FilterFrameText = null;
         if(tipData is Array)
         {
            _vbox.disposeAllChildren();
            _loc1_ = tipData as Array;
            _loc4_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc1_.length)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID((_loc1_[_loc7_] as BoxItemTemplate).TemplateId);
               _loc6_ = int((_loc1_[_loc7_] as BoxItemTemplate).Count);
               _loc5_ = int(_loc3_.Profile);
               _loc8_ = _loc3_.TemplateName;
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("tip.MultipleGoodsTips.txt");
               _vbox.addChild(_loc2_);
               _loc2_.text = _loc8_ + "×" + _loc6_;
               _loc2_.setFrame(_loc5_);
               if(_loc2_.textWidth > _loc4_)
               {
                  _loc4_ = int(_loc2_.textWidth);
               }
               _loc7_++;
            }
            _bg.width = _vbox.x + _loc4_ + 20;
            _bg.height = _vbox.y + _vbox.height + 20;
         }
      }
      
      override public function dispose() : void
      {
         while(_vbox.numChildren)
         {
            _vbox.removeChildAt(_vbox.numChildren - 1);
            ObjectUtils.disposeObject(_vbox.getChildAt(_vbox.numChildren - 1));
         }
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

