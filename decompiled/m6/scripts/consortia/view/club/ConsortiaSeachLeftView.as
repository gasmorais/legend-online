package consortia.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.IMEManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaSeachLeftView extends Sprite implements Disposeable
   {
      
      private var _leftBg:Scale9CornerImage;
      
      private var _searchBg:Bitmap;
      
      private var _titlebarBg:MutipleImage;
      
      private var _listBg:Scale9CornerImage;
      
      private var _randomBtn:IconButton;
      
      private var _searchBtn:SelectedButton;
      
      private var _joinConsortiaBtn:IconButton;
      
      private var _searchTxt:FilterFrameText;
      
      private var _consortiaNameTxt1:FilterFrameText;
      
      private var _chairmanTxt1:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _memberTxt:FilterFrameText;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _data:ConsortiaModel;
      
      private var _consortiaItemGroup:SelectedButtonGroup;
      
      private var _consortiaItemList:Vector.<ConsortiaItem>;
      
      private var _contorller:ConsortiaControler;
      
      private var _count:int = 0;
      
      private var _inputStr:String = "";
      
      private var _searchCount:int;
      
      private var _selectAllBtn:SelectedCheckButton;
      
      public function ConsortiaSeachLeftView(param1:ConsortiaControler, param2:ConsortiaModel)
      {
         super();
         _contorller = param1;
         _data = param2;
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _consortiaItemList = new Vector.<ConsortiaItem>();
         _consortiaItemGroup = new SelectedButtonGroup();
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("consortia.leftDescribeBackground");
         _listBg = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaListBG");
         _searchBg = ComponentFactory.Instance.creatBitmap("asset.consortia.searchBg");
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("consortia.titlebarImg");
         _selectAllBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaAddselectAll");
         _randomBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.randomBtn");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.searchBtn");
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.searchFrameInputTipTextStyle");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.searchTextStyle");
         _consortiaNameTxt1 = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaNameTextStyle");
         _chairmanTxt1 = ComponentFactory.Instance.creatComponentByStylename("consortia.chairmanTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.gradeTextStyle");
         _memberTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.memberTextStyle");
         _joinConsortiaBtn = ComponentFactory.Instance.creatComponentByStylename("core.joinConsortiaBtn");
         _inputTipTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.command01");
         _searchTxt.maxChars = 10;
         addChild(_leftBg);
         addChild(_searchBg);
         addChild(_selectAllBtn);
         addChild(_listBg);
         addChild(_titlebarBg);
         addChild(_randomBtn);
         addChild(_searchBtn);
         addChild(_inputTipTxt);
         addChild(_searchTxt);
         addChild(_selectAllBtn);
         _selectAllBtn.text = LanguageMgr.GetTranslation("emailII.EmailFrame.allSelect");
         addChild(_consortiaNameTxt1);
         _consortiaNameTxt1.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.consortiaNameTxt1Text");
         addChild(_chairmanTxt1);
         _chairmanTxt1.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.chairmanTxt1Text");
         addChild(_gradeTxt);
         _gradeTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.gradeTxtText");
         addChild(_memberTxt);
         _memberTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.memberTxtText");
         addChild(_joinConsortiaBtn);
      }
      
      private function uninit() : void
      {
         for each(var _loc1_:ConsortiaItem in _consortiaItemList)
         {
            _loc1_.dispose();
         }
         _consortiaItemList = null;
         _consortiaItemGroup.dispose();
         _consortiaItemGroup = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initData() : void
      {
         _contorller.getConsortiaInviteInfos();
         setConsortiaItemList();
         ConsortiaSocektSendManager.searchConsortia("",1,true);
         _contorller.randomCount = 1;
      }
      
      private function setConsortiaItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaItem = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ConsortiaItem();
            _loc1_.x = 7;
            _loc1_.y = 80 + _loc2_ * (_loc1_.height - 1);
            addChild(_loc1_);
            _consortiaItemGroup.addSelectItem(_loc1_);
            _consortiaItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("keyDown",__onKeydownHandler);
         _searchBtn.addEventListener("click",__onSearchHandler);
         _randomBtn.addEventListener("click",__onRandomHandler);
         _searchTxt.addEventListener("focusIn",__onFocusInHandler);
         _searchTxt.addEventListener("focusOut",__onFocusOutHandler);
         _joinConsortiaBtn.addEventListener("click",__onJoinHandler);
         _data.addEventListener("UPDA_CONSORTIA_LIST",__onSearchListUpdata);
         _selectAllBtn.addEventListener("click",__selectAllBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("keyDown",__onKeydownHandler);
         _searchBtn.removeEventListener("click",__onSearchHandler);
         _randomBtn.removeEventListener("click",__onRandomHandler);
         _searchTxt.removeEventListener("focusIn",__onFocusInHandler);
         _searchTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _joinConsortiaBtn.removeEventListener("click",__onJoinHandler);
         _data.removeEventListener("UPDA_CONSORTIA_LIST",__onSearchListUpdata);
         _selectAllBtn.removeEventListener("click",__selectAllBtnHandler);
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onSearchHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __selectAllBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:ConsortiaItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(_consortiaItemList.length);
         var _loc5_:Boolean = getSelected();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _consortiaItemList[_loc3_] as ConsortiaItem;
            _loc4_.setCheckState(_loc5_);
            _loc3_++;
         }
      }
      
      private function getSelected() : Boolean
      {
         var _loc1_:ConsortiaItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_consortiaItemList.length);
         var _loc2_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(!_consortiaItemList[_loc4_])
            {
               return _loc2_;
            }
            _loc1_ = _consortiaItemList[_loc4_] as ConsortiaItem;
            if(!_loc1_.checked)
            {
               return true;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function getSelectedItem() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ConsortiaItem in _consortiaItemList)
         {
            if(_loc2_.data)
            {
               if(_loc2_.checked)
               {
                  _loc1_.push(_loc2_.data.consortiaId);
               }
            }
         }
         return _loc1_;
      }
      
      private function __onSearchHandler(param1:Event) : void
      {
         cleanItemState();
         if(_searchTxt.text == "")
         {
            _contorller.randomCount++;
            ConsortiaSocektSendManager.searchConsortia("",_contorller.randomCount,false);
            return;
         }
         _contorller.randomCount++;
         if(_inputStr != _searchTxt.text)
         {
            _contorller.randomCount = 1;
         }
         else if((_contorller.randomCount - 1) * 8 >= _contorller.model.setTotalRows)
         {
            _contorller.randomCount = 1;
         }
         _inputStr = _searchTxt.text;
         ConsortiaSocektSendManager.searchConsortia(_searchTxt.text,_contorller.randomCount,true);
         SoundManager.instance.play("022");
      }
      
      private function __onRandomHandler(param1:Event) : void
      {
         _contorller.randomCount++;
         ConsortiaSocektSendManager.searchConsortia("",_contorller.randomCount,false);
         SoundManager.instance.play("022");
         cleanItemState();
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _searchTxt.text = "";
         _inputTipTxt.visible = false;
      }
      
      private function __onFocusOutHandler(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_searchTxt.text))
         {
            _inputTipTxt.visible = true;
         }
      }
      
      private function __onJoinHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:Array = getSelectedItem();
         if(!_loc2_ || _loc2_.length <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.command02");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(_loc2_.length + _data.applyList.length > 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.ConsortiaControler.command04"));
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            ConsortiaSocektSendManager.applyJoinConsortia(_loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      private function __onSearchListUpdata(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = 0;
         _consortiaItemGroup.selectIndex = -1;
         var _loc3_:Array = _data.consortiaList;
         _loc2_ = 0;
         while(_loc2_ < _consortiaItemList.length)
         {
            _consortiaItemList[_loc2_].data = _loc2_ < _loc3_.length ? ConsortiaInfo(_loc3_[_loc2_]) : null;
            _loc2_++;
         }
      }
      
      private function __itemClickHandler(param1:ConsortiaEvent) : void
      {
      }
      
      public function cleanItemState() : void
      {
         var _loc3_:ConsortiaItem = null;
         var _loc2_:int = 0;
         var _loc1_:int = int(_consortiaItemList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _consortiaItemList[_loc2_] as ConsortiaItem;
            _loc3_.setCheckState(false);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

