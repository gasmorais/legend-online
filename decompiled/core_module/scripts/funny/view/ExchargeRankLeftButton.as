package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import mvc.module.exchargerank.ExchargeData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class ExchargeRankLeftButton extends SelectedIconTextButton
   {
      
      private var _data:ExchargeData;
      
      private var _gradientText:GradientText;
      
      private var _getIcon:Bitmap;
      
      private var _newIcon:Bitmap;
      
      public function ExchargeRankLeftButton()
      {
         super();
         initGradientText();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_gradientText)
         {
            addChild(_gradientText);
         }
      }
      
      private function initGradientText() : void
      {
         _gradientText = ComponentFactory.Instance.creatComponentByStylename("exchargerankLeftButton.title");
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "none";
         _loc1_.width = 140;
         _loc1_.height = 40;
         _loc1_.selectable = false;
         _loc1_.wordWrap = true;
         _loc1_.multiline = true;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.size = 14;
         _loc2_.bold = true;
         _loc2_.align = "center";
         _loc1_.defaultTextFormat = _loc2_;
         _gradientText.textField = _loc1_;
         _gradientText.visible = false;
      }
      
      public function set data(param1:ExchargeData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         text = _data.title;
         setState();
      }
      
      private function setState() : void
      {
         unSelectedStyle = "asset.exchargerank.leftBtn1";
         selectedStyle = "asset.exchargerank.leftBtn2";
         _text.y = 10;
         _gradientText.y = 7;
      }
      
      public function get data() : ExchargeData
      {
         return _data;
      }
      
      override public function set text(param1:String) : void
      {
         _gradientText.text = param1;
         if(_text)
         {
            _text.text = param1;
            _text.y = 17 - 4 * (_text.numLines - 1);
            _gradientText.y = 15 - 7 * (_gradientText.textField.numLines - 1);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(!_text)
         {
            return;
         }
         if(param1)
         {
            _text.setFrame(2);
            _text.visible = false;
            _gradientText.visible = true;
         }
         else
         {
            _text.setFrame(1);
            _text.visible = true;
            _gradientText.visible = false;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_gradientText);
         super.dispose();
      }
   }
}

