package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import funny.FunnyEvent;
   import funny.datas.FunnyData;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   
   public class FunnyLeftButton extends SelectedIconTextButton
   {
      
      private var _data:FunnyData;
      
      private var _gradientText:GradientText;
      
      private var _getIcon:Bitmap;
      
      private var _newIcon:Bitmap;
      
      public function FunnyLeftButton()
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
         _gradientText = ComponentFactory.Instance.creatComponentByStylename("funnyLeftButton.title");
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "none";
         _loc1_.width = 155;
         _loc1_.height = 45;
         _loc1_.selectable = false;
         _loc1_.wordWrap = true;
         _loc1_.multiline = true;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.size = 14;
         _loc2_.bold = true;
         _loc2_.align = "center";
         _loc2_.leading = 0;
         _loc1_.defaultTextFormat = _loc2_;
         _gradientText.textField = _loc1_;
         _gradientText.visible = false;
      }
      
      public function set data(param1:FunnyData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         text = _data.title;
         setState();
         setIconVisible();
      }
      
      private function setIconVisible() : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.type == 1005)
         {
            if(_newIcon == null)
            {
               _newIcon = ComponentFactory.Instance.creatBitmap("asset.groupbuy.tuangouicon");
               addChild(_newIcon);
            }
            return;
         }
         if(!_newIcon)
         {
            _newIcon = ComponentFactory.Instance.creatBitmap("asset.funny.newIcon");
            addChild(_newIcon);
         }
         if(!oldDic[_data.id])
         {
            _newIcon.visible = true;
         }
         else
         {
            _newIcon.visible = false;
         }
         if(!_getIcon)
         {
            _getIcon = ComponentFactory.Instance.creatBitmap("asset.funny.leftIcon");
            addChild(_getIcon);
         }
         if(_data.anyToGet)
         {
            _getIcon.visible = true;
            _newIcon.visible = false;
         }
         else
         {
            _getIcon.visible = false;
         }
      }
      
      private function setState() : void
      {
         if(_data.type != 1001)
         {
            unSelectedStyle = "asset.funny.leftBtn1";
            selectedStyle = "asset.funny.leftBtn2";
            removeEventListener("REFRESH_ITEM",__refreshHandler);
            addEventListener("REFRESH_ITEM",__refreshHandler);
         }
         else
         {
            unSelectedStyle = "asset.funny.leftBtn3";
            selectedStyle = "asset.funny.leftBtn4";
            _text.y = 10;
            _gradientText.y = 7;
         }
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         setIconVisible();
      }
      
      public function get data() : FunnyData
      {
         return _data;
      }
      
      override public function set text(param1:String) : void
      {
         _gradientText.text = param1;
         if(_text)
         {
            _text.text = param1;
            if(_data.type != 1001)
            {
               _text.y = 17 - 4 * (_text.numLines - 1);
            }
            if(_data.type != 1001)
            {
               _gradientText.y = 15 - 7 * (_gradientText.textField.numLines - 1);
            }
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
            if(_data.type != 1005)
            {
               if(_newIcon)
               {
                  _newIcon.visible = false;
               }
               oldDic[_data.id] = _data.id;
               SharedManager.instance.savefunnyOldDic();
               TopToolsBar.instance.onBtnTipsUpdate();
            }
         }
         else
         {
            _text.setFrame(1);
            _text.visible = true;
            _gradientText.visible = false;
         }
      }
      
      private function get oldDic() : Dictionary
      {
         return SharedManager.instance.funnyOldDic;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEventListener("REFRESH_ITEM",__refreshHandler);
         _data = null;
         ObjectUtils.disposeObject(_gradientText);
         super.dispose();
      }
   }
}

