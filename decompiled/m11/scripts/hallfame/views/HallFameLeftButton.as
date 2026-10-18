package hallfame.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class HallFameLeftButton extends SelectedIconTextButton
   {
      
      private var _data:FunnyBagData;
      
      private var _index:int;
      
      private var _btnBack:ScaleFrameImage;
      
      private var _content:ScaleFrameImage;
      
      private var _tipTxt:FilterFrameText;
      
      private var _getIcon:Bitmap;
      
      public function HallFameLeftButton(param1:int)
      {
         _index = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _btnBack = ComponentFactory.Instance.creatComponentByStylename("hallfame.views.back",[true]);
         _content = ComponentFactory.Instance.creatComponentByStylename("hallfame.views.content");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("hallfame.views.tipTxt");
         _tipTxt.alpha = 0.75;
         _btnBack.setFrame(_index);
         _content.setFrame(_index);
         _tipTxt.text = LanguageMgr.GetTranslation("hallfame.views.tipTxt");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_btnBack)
         {
            addChild(_btnBack);
         }
         if(_content)
         {
            addChild(_content);
         }
         if(_tipTxt)
         {
            addChild(_tipTxt);
         }
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _text.text = LanguageMgr.GetTranslation("hallfame.views.contentTxt",_data.conditionList[0].value);
         setIconVisible();
      }
      
      private function setIconVisible() : void
      {
         if(!_data)
         {
            return;
         }
         if(!_getIcon)
         {
            _getIcon = ComponentFactory.Instance.creatBitmap("asset.hallfame.getIcon");
            addChild(_getIcon);
         }
         if(_data.status == 1 && open)
         {
            _getIcon.visible = true;
         }
         else
         {
            _getIcon.visible = false;
         }
      }
      
      private function get open() : Boolean
      {
         var _loc1_:FunnyData = FunnyManager.instance.model.findDataByType(146);
         if(_loc1_.startTime < playerModel.nowDate && playerModel.nowDate < _loc1_.endTime)
         {
            return true;
         }
         return false;
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         setIconVisible();
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(!_text)
         {
            return;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_btnBack);
         _btnBack = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_getIcon);
         _getIcon = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         super.dispose();
      }
   }
}

