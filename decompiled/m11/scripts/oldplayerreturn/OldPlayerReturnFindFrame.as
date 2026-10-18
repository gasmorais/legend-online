package oldplayerreturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnFindFrame extends Frame implements IManualSize
   {
      
      private var _recommendBtn:SelectedIconButton;
      
      private var _applyBtn:SelectedIconButton;
      
      private var _inviteBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _border:Scale9CornerImage;
      
      private var _txt:FilterFrameText;
      
      private var _back:ScaleBitmapImage;
      
      private var _searchBtn:IconButton;
      
      private var _inputTxt:FilterFrameText;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _listBorder:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _spanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _sprite:Sprite;
      
      public function OldPlayerReturnFindFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,508,513);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("OldPlayerReturnFindFrame.titleText.text");
         _recommendBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.recommendBtn");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.applyBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.inviteBtn");
         _border = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.border");
         _txt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.txt");
         _back = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.back");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.searchBtn");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.inputTxt");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.titleBg");
         _listBorder = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.listBorder");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.nameTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.fightTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.numTxt");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFindFrame.bossSpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFindFrame.vBox");
         _sprite = new Sprite();
         addToContent(_border);
         addToContent(_recommendBtn);
         addToContent(_applyBtn);
         addToContent(_inviteBtn);
         addToContent(_txt);
         addToContent(_back);
         addToContent(_searchBtn);
         addToContent(_inputTxt);
         addToContent(_sprite);
         _sprite.addChild(_titleBg);
         _sprite.addChild(_listBorder);
         _sprite.addChild(_nameTxt);
         _sprite.addChild(_fightTxt);
         _sprite.addChild(_numTxt);
         _sprite.addChild(_spanel);
         _spanel.setView(_vBox);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_recommendBtn);
         _group.addSelectItem(_applyBtn);
         _group.addSelectItem(_inviteBtn);
         _txt.text = LanguageMgr.GetTranslation("oldPlayerReturnFindFrame.txt.text");
         _nameTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnFindFrame.nameTxt.text");
         _fightTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnFindFrame.fightTxt.text");
         _numTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnFindFrame.numTxt.text");
      }
      
      private function refreshItem(param1:Array) : void
      {
         var _loc2_:OldPlayerReturnFindItem = null;
         var _loc3_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new OldPlayerReturnFindItem(_group.selectIndex);
            _loc2_.data = param1[_loc3_];
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
         _vBox.commitChanges();
         _spanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__groupChangeHandler);
         NotificationManager.instance.addEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
         NotificationManager.instance.addEventListener("SEARCH_ALLY_EVENT",__searchAllyUpdateHandler);
         _searchBtn.addEventListener("click",__searchBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__groupChangeHandler);
         NotificationManager.instance.removeEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
         NotificationManager.instance.removeEventListener("SEARCH_ALLY_EVENT",__searchAllyUpdateHandler);
         _searchBtn.removeEventListener("click",__searchBtnClickHandler);
      }
      
      private function __searchBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = _inputTxt.text;
         OldPlayerReturnManager.instance.sendSearch(_loc2_);
      }
      
      private function __userDataUpdateHandler(param1:NotificationEvent) : void
      {
         if(_group.selectIndex == 0)
         {
            return;
         }
         refreshView();
      }
      
      private function __searchAllyUpdateHandler(param1:NotificationEvent) : void
      {
         if(_group.selectIndex > 0)
         {
            return;
         }
         refreshView();
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         if(_group.selectIndex == 0)
         {
            OldPlayerReturnManager.instance.sendSearch();
         }
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(model.isReturnPlayer)
         {
            _titleBg.setFrame(1);
            _numTxt.visible = true;
            _fightTxt.x = 160;
         }
         else
         {
            _titleBg.setFrame(2);
            _numTxt.visible = false;
            _fightTxt.x = 210;
         }
         if(_group.selectIndex == 0)
         {
            _txt.visible = true;
            _back.visible = true;
            _searchBtn.visible = true;
            _inputTxt.text = "";
            _sprite.y = 0;
            _spanel.height = 285;
            _listBorder.height = 292;
         }
         else
         {
            _txt.visible = false;
            _back.visible = false;
            _searchBtn.visible = false;
            _inputTxt.text = "";
            _sprite.y = -60;
            _spanel.height = 345;
            _listBorder.height = 350;
         }
         var _loc1_:Array = [];
         switch(int(_group.selectIndex))
         {
            case 0:
               _loc1_ = model.playerList;
               break;
            case 1:
               _loc1_ = model.applyList;
               break;
            case 2:
               _loc1_ = model.inviteList;
         }
         refreshItem(_loc1_);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_recommendBtn);
         _recommendBtn = null;
         ObjectUtils.disposeObject(_applyBtn);
         _applyBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_searchBtn);
         _searchBtn = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_listBorder);
         _listBorder = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         for each(var _loc1_:OldPlayerReturnFindItem in _vBox)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

