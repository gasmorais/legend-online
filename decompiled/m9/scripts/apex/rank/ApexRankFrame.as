package apex.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexRankModel;
   import mvc.module.apex.ApexRankTeamData;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ApexManager;
   
   public class ApexRankFrame extends Frame
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _txtRankUpdateTime:FilterFrameText;
      
      private var _txtRankOver:FilterFrameText;
      
      private var _txtRankMyRank:FilterFrameText;
      
      private var _txtRankMyScore:FilterFrameText;
      
      private var _txtRankPageText:FilterFrameText;
      
      private var _txtRankStr1:FilterFrameText;
      
      private var _txtRankStr2:FilterFrameText;
      
      private var _txtRankStr3:FilterFrameText;
      
      private var _txtRankStr4:FilterFrameText;
      
      private var _imgRankGroup:ScaleFrameImage;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var frameBg:MutipleImage;
      
      private var pageBg:Image;
      
      private var btnLast:IconButton;
      
      private var btnNext:IconButton;
      
      private var img2:ScaleLeftRightImage;
      
      private var btnTab1:SelectedIconButton;
      
      private var btnTab2:SelectedIconButton;
      
      private var btnTab3:SelectedIconButton;
      
      private var btnTab4:SelectedIconButton;
      
      private var btnTab5:SelectedIconButton;
      
      private var btnTab6:SelectedIconButton;
      
      private var hbox:HBox;
      
      private var vbox:VBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var itemList:Array;
      
      private var rankModel:ApexRankModel;
      
      private var selectedGroup:int;
      
      private var currentPage:int = 1;
      
      private var totalPage:int;
      
      private var currentGroupData:Array;
      
      private const ONE_PAGE_COUNT:int = 8;
      
      public function ApexRankFrame()
      {
         super();
         rankModel = ApexManager.instance.model.apexRankModel;
         initView();
         addEvent();
         _buttonGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.str.myScore");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.str.myrank2");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apex.rank.str2");
         frameBg = ComponentFactory.Instance.creatComponentByStylename("apex.guess.rank.framebg");
         _txtRankUpdateTime = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankUpdateTime");
         _txtRankOver = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankOver");
         _txtRankMyRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankMyRank");
         _txtRankMyScore = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankMyScore");
         _txtRankPageText = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankPageText");
         _txtRankStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankStr1");
         _txtRankStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankStr2");
         _txtRankStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankStr3");
         _txtRankStr4 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankStr4");
         _imgRankGroup = ComponentFactory.Instance.creatComponentByStylename("ui.apex.imgRankGroup");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apex.rank.bg");
         pageBg = ComponentFactory.Instance.creatComponentByStylename("apex.rank.pageBg");
         btnLast = ComponentFactory.Instance.creatComponentByStylename("apex.rank.btnLast");
         btnNext = ComponentFactory.Instance.creatComponentByStylename("apex.rank.btnNext");
         img2 = ComponentFactory.Instance.creatComponentByStylename("apex.rank.textBg3");
         hbox = ComponentFactory.Instance.creatComponentByStylename("apex.hbox.rank.hbox");
         btnTab1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt1");
         btnTab2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt2");
         btnTab3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt3");
         btnTab4 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt4");
         btnTab5 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt5");
         btnTab6 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.rank.textBt6");
         addChild(frameBg);
         addChild(_bit2);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_bit3);
         addChild(img2);
         addChild(_txtRankUpdateTime);
         addChild(_txtRankOver);
         addChild(_txtRankMyRank);
         addChild(_txtRankMyScore);
         addChild(_txtRankStr1);
         addChild(_txtRankStr2);
         addChild(_txtRankStr3);
         addChild(_txtRankStr4);
         addChild(_imgRankGroup);
         addChild(pageBg);
         addChild(btnLast);
         addChild(btnNext);
         addChild(_txtRankPageText);
         hbox.addChild(btnTab1);
         hbox.addChild(btnTab2);
         hbox.addChild(btnTab3);
         hbox.addChild(btnTab4);
         hbox.addChild(btnTab5);
         hbox.addChild(btnTab6);
         addChild(hbox);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(btnTab1);
         _buttonGroup.addSelectItem(btnTab2);
         _buttonGroup.addSelectItem(btnTab3);
         _buttonGroup.addSelectItem(btnTab4);
         _buttonGroup.addSelectItem(btnTab5);
         _buttonGroup.addSelectItem(btnTab6);
         titleText = LanguageMgr.GetTranslation("apex.rank.title");
         _txtRankStr1.text = LanguageMgr.GetTranslation("apex.rank.str1");
         _txtRankStr2.text = LanguageMgr.GetTranslation("apex.rank.str2");
         _txtRankStr3.text = LanguageMgr.GetTranslation("apex.rank.str3");
         _txtRankStr4.text = LanguageMgr.GetTranslation("apex.rank.str4");
         _txtRankOver.text = ApexManager.instance.model.apexState.overText;
         _txtRankPageText.text = "1/1";
         initListView();
         if(rankModel.myData)
         {
            _imgRankGroup.visible = true;
            _bit3.visible = true;
            _imgRankGroup.setFrame(rankModel.myData.group);
            _txtRankMyRank.text = rankModel.myData.rank + "";
            _txtRankMyScore.text = rankModel.myData.score + "";
            _txtRankMyRank.x = 208;
         }
         else
         {
            _imgRankGroup.visible = false;
            _bit3.visible = false;
            _txtRankMyRank.text = LanguageMgr.GetTranslation("apex.rank.str7");
            _txtRankMyScore.text = "0";
            _txtRankMyRank.x = 128;
         }
         _txtRankUpdateTime.text = LanguageMgr.GetTranslation("apex.rank.str5",rankModel.lastUpdateStr);
      }
      
      private function refreshData() : void
      {
         currentGroupData = rankModel.getGroupAllData(selectedGroup);
         totalPage = Math.ceil(currentGroupData.length / 8);
         currentPage = 1;
         currentGroupData.sort(function(param1:ApexRankTeamData, param2:ApexRankTeamData):int
         {
            if(param1.rank > param2.rank)
            {
               return 1;
            }
            if(param1.rank < param2.rank)
            {
               return -1;
            }
            return 0;
         });
         flipPage();
      }
      
      private function flipPage() : void
      {
         var _loc2_:ApexRankTeamData = null;
         var _loc3_:int = 0;
         var _loc1_:ApexRankListItem = null;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc1_ = itemList[_loc3_];
            _loc2_ = currentGroupData[(currentPage - 1) * 8 + _loc3_];
            _loc1_.data = _loc2_;
            _loc3_++;
         }
         if(totalPage == 0)
         {
            _txtRankPageText.text = "1/1";
         }
         else
         {
            _txtRankPageText.text = currentPage + "/" + totalPage;
         }
      }
      
      private function initListView() : void
      {
         var _loc1_:ApexRankListItem = null;
         var _loc2_:int = 0;
         vbox = ComponentFactory.Instance.creatComponentByStylename("apex.vbox.rank.vbox");
         addChild(vbox);
         itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ApexRankListItem();
            vbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",_onClickBtnHandler);
         btnLast.addEventListener("click",onPageLast);
         btnNext.addEventListener("click",onPageNext);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buttonGroup.removeEventListener("change",_onClickBtnHandler);
         btnLast.removeEventListener("click",onPageLast);
         btnNext.removeEventListener("click",onPageNext);
      }
      
      private function onPageNext(param1:MouseEvent) : void
      {
         if(currentPage < totalPage)
         {
            currentPage = currentPage + 1;
         }
         flipPage();
      }
      
      private function onPageLast(param1:MouseEvent) : void
      {
         if(currentPage > 1)
         {
            currentPage = currentPage - 1;
         }
         flipPage();
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
      
      private function _onClickBtnHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         selectedGroup = 6 - _buttonGroup.selectIndex;
         refreshData();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_txtRankUpdateTime);
         _txtRankUpdateTime = null;
         ObjectUtils.disposeObject(_txtRankOver);
         _txtRankOver = null;
         ObjectUtils.disposeObject(_txtRankMyRank);
         _txtRankMyRank = null;
         ObjectUtils.disposeObject(_txtRankMyScore);
         _txtRankMyScore = null;
         ObjectUtils.disposeObject(_txtRankPageText);
         _txtRankPageText = null;
         ObjectUtils.disposeObject(_txtRankStr1);
         _txtRankStr1 = null;
         ObjectUtils.disposeObject(_txtRankStr2);
         _txtRankStr2 = null;
         ObjectUtils.disposeObject(_txtRankStr3);
         _txtRankStr3 = null;
         ObjectUtils.disposeObject(_txtRankStr4);
         _txtRankStr4 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_imgRankGroup);
         _imgRankGroup = null;
         ObjectUtils.disposeObject(frameBg);
         frameBg = null;
         ObjectUtils.disposeObject(pageBg);
         pageBg = null;
         ObjectUtils.disposeObject(btnLast);
         btnLast = null;
         ObjectUtils.disposeObject(btnNext);
         btnNext = null;
         ObjectUtils.disposeObject(img2);
         img2 = null;
         ObjectUtils.disposeObject(btnTab1);
         btnTab1 = null;
         ObjectUtils.disposeObject(btnTab2);
         btnTab2 = null;
         ObjectUtils.disposeObject(btnTab3);
         btnTab3 = null;
         ObjectUtils.disposeObject(btnTab4);
         btnTab4 = null;
         ObjectUtils.disposeObject(btnTab5);
         btnTab5 = null;
         ObjectUtils.disposeObject(btnTab6);
         btnTab6 = null;
         ObjectUtils.disposeObject(hbox);
         hbox = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

