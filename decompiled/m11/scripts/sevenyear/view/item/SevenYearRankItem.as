package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.sevenyear.SevenYearRankInfo;
   
   public class SevenYearRankItem extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _line:Image;
      
      private var _data:SevenYearRankInfo;
      
      public function SevenYearRankItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankItem.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankItem.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankItem.gradeTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankItem.line");
         addChild(_bg);
         _bg.visible = false;
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_line);
      }
      
      public function set data(param1:SevenYearRankInfo) : void
      {
         clear();
         if(!param1)
         {
            return;
         }
         _data = param1;
         _nameTxt.text = _data.nickName + "[ " + _data.severName + " ]";
         _gradeTxt.text = _data.flagGrade.toString();
      }
      
      private function clear() : void
      {
         _bg.visible = false;
         _nameTxt.text = "";
         _gradeTxt.text = "";
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__onMouseOver);
         addEventListener("rollOut",__onMouseOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseOver);
         removeEventListener("rollOut",__onMouseOut);
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.visible = true;
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
   }
}

