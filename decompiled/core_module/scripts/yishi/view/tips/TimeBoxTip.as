package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.BoxManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.BaseBoxGoodsItem;
   
   public class TimeBoxTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _timePeriod:int = 0;
      
      public function TimeBoxTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 240;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.tiemboxtiptitle");
         addChild(_title);
         _title.text = LanguageMgr.GetTranslation("box.timeBox.TimeBoxView.time");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("tips.timeboxtipVbox");
         addChild(_vbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:BaseBoxGoodsItem = null;
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = BoxManager.instance.getCurrentTimePeriod();
         if(_loc3_ == _timePeriod)
         {
            return;
         }
         _timePeriod = _loc3_;
         var _loc1_:Array = TempleteManager.instance.timeBoxTemplateCate.getTemplatesByIndex(_timePeriod);
         if(_loc1_ && _loc1_.length > 0)
         {
            ObjectUtils.disposeAllChildren(_vbox);
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = int(_loc1_[_loc4_].TemplateId);
               _loc5_.count = int(_loc1_[_loc4_].Data);
               _loc2_ = new BaseBoxGoodsItem();
               _loc2_.direction = 2;
               _loc2_.data = _loc5_;
               _vbox.addChild(_loc2_);
               _loc4_++;
            }
            _bg.height = _vbox.height + 95;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

