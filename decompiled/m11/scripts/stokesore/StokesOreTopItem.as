package stokesore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StokesOreManager;
   import mvc.module.stokesore.StokesOreModel;
   
   public class StokesOreTopItem extends Component
   {
      
      private var _radiuImage:Image;
      
      private var _number:ScaleFrameImage;
      
      private var _oreBtn:BaseButton;
      
      private var _descTxt:FilterFrameText;
      
      private var _layer:int;
      
      private var _index:int;
      
      private var _defaultSelected:Boolean;
      
      public function StokesOreTopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _number.setFrame(_index);
      }
      
      public function set layer(param1:int) : void
      {
         _layer = param1;
         _descTxt.text = LanguageMgr.GetTranslation("stokesore.StokesOreTopItem.layer",_layer);
         tipData = model.goodsDic[_layer];
      }
      
      private function initView() : void
      {
         _radiuImage = ComponentFactory.Instance.creatComponentByStylename("stokesOreTopItem.radiuImage");
         _number = ComponentFactory.Instance.creatComponentByStylename("stokesOreTopItem.number");
         _oreBtn = ComponentFactory.Instance.creatComponentByStylename("stokesOreTopItem.oreBtn");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreTopItem.descTxt");
         addChild(_radiuImage);
         addChild(_number);
         addChild(_oreBtn);
         addChild(_descTxt);
      }
      
      private function addEvent() : void
      {
         _oreBtn.addEventListener("mouseOver",__mouseOverHandler);
      }
      
      private function removeEvent() : void
      {
         if(_oreBtn)
         {
            _oreBtn.removeEventListener("mouseOver",__mouseOverHandler);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _oreBtn.tipData = model.goodsDic[_index];
      }
      
      private function get model() : StokesOreModel
      {
         return StokesOreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_radiuImage);
         _radiuImage = null;
         ObjectUtils.disposeObject(_number);
         _number = null;
         ObjectUtils.disposeObject(_oreBtn);
         _oreBtn = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         super.dispose();
      }
   }
}

