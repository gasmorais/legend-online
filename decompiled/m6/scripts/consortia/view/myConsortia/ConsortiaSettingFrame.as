package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaSettingFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _memberTxt:FilterFrameText;
      
      private var _chairmanTxt:FilterFrameText;
      
      private var _vicePresidentTxt:FilterFrameText;
      
      private var _officerTxt:FilterFrameText;
      
      private var _eliteTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _contorller:ConsortiaControler;
      
      private var _data:ConsortiaModel;
      
      private var _tabSpanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function ConsortiaSettingFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,558,395);
      }
      
      private function initView() : void
      {
         _contorller = FrameControllerManager.instance.consortiaController;
         _data = _contorller.model;
         if(isChairman)
         {
            titleText = LanguageMgr.GetTranslation("ConsortiaSettingFrame.titleText.text1");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("ConsortiaSettingFrame.titleText.text2");
         }
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSettingFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.settingBg");
         _memberTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.memberTxt");
         _chairmanTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.chairmanTxt");
         _vicePresidentTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.vicePresidentTxt");
         _officerTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.officerTxt");
         _eliteTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.eliteTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.descTxt");
         _tabSpanel = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.tabSpanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSettingFrame.vBox");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_memberTxt);
         addToContent(_chairmanTxt);
         addToContent(_vicePresidentTxt);
         addToContent(_officerTxt);
         addToContent(_eliteTxt);
         addToContent(_descTxt);
         addToContent(_tabSpanel);
         _tabSpanel.setView(_vBox);
         _memberTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.memberTxt.text");
         _chairmanTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.chairmanTxt.text");
         _vicePresidentTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.vicePresidentTxt.text");
         _officerTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.officerTxt.text");
         _eliteTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.eliteTxt.text");
         _descTxt.text = LanguageMgr.GetTranslation("ConsortiaSettingFrame.descTxt.text");
         _memberTxt.height = 20 * _memberTxt.numLines;
         _memberTxt.y = 10 - 7 * (_memberTxt.numLines - 1);
         _vicePresidentTxt.height = 20 * _vicePresidentTxt.numLines;
         _vicePresidentTxt.y = 10 - 7 * (_vicePresidentTxt.numLines - 1);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaSettingItem = null;
         _tabSpanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 15)
         {
            _loc1_ = new ConsortiaSettingItem(_loc2_,isChairman);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _tabSpanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get isChairman() : Boolean
      {
         if(_data && _data.consortiaInfo.chairmanID == playerInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_memberTxt);
         _memberTxt = null;
         ObjectUtils.disposeObject(_chairmanTxt);
         _chairmanTxt = null;
         ObjectUtils.disposeObject(_vicePresidentTxt);
         _vicePresidentTxt = null;
         ObjectUtils.disposeObject(_officerTxt);
         _officerTxt = null;
         ObjectUtils.disposeObject(_eliteTxt);
         _eliteTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

