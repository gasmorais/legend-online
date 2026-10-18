package secretary.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   
   public class SecretaryTabItem extends SelectedIconTextButton
   {
      
      private var _gradientText:GradientText;
      
      private var _type:int = 0;
      
      public function SecretaryTabItem()
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
         _gradientText = ComponentFactory.Instance.creatComponentByStylename("LittleSecretaryFrame.title");
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
      
      override public function set text(param1:String) : void
      {
         _gradientText.text = param1;
         if(_text)
         {
            _text.text = param1;
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         refreshIcon();
      }
      
      public function refreshIcon() : void
      {
         var _loc3_:KingbackInfo = null;
         var _loc1_:int = 0;
         if(_type <= 0)
         {
            return;
         }
         if(_type == 3)
         {
            return;
         }
         var _loc2_:Array = model.getInfoListByType(_type);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc1_];
            _loc1_++;
         }
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
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
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_gradientText);
         _gradientText = null;
         super.dispose();
      }
   }
}

