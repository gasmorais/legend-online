package selectcampaign.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SelectCampaignEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DistrictRewardTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class AreaView extends Sprite implements Disposeable
   {
      
      private var _map:SelectCpMapView;
      
      private var _areaComboxBg:Bitmap;
      
      private var _areaCombox:ComboBox;
      
      private var _cpInfoView:CampaignInfoView;
      
      private var _chapterRewardView:ChapterRewardView;
      
      private var _currentIndex:int;
      
      private var _chapterList:Array;
      
      private var _chapterRewardBtn1:BaseButton;
      
      private var _chapterRewardBtn2:IconButton;
      
      private var _chapterPreBtn:BaseButton;
      
      private var _chapterNextBtn:BaseButton;
      
      private var _point:Point;
      
      private var _openLen:int;
      
      public function AreaView()
      {
         super();
         initView();
         initEvents();
         defaultView();
      }
      
      private function initView() : void
      {
         _map = ComponentFactory.Instance.creatCustomObject("selectCP.MapView");
         _areaComboxBg = ComponentFactory.Instance.creatBitmap("asset.selectCP.AreaComBoxBg");
         _areaCombox = ComponentFactory.Instance.creatComponentByStylename("SelectCP.AreaCombox");
         _cpInfoView = ComponentFactory.Instance.creatCustomObject("selectCp.InfoView");
         _chapterRewardBtn1 = ComponentFactory.Instance.creatComponentByStylename("selecteCP.ChapterRewardBtn1");
         _chapterRewardBtn2 = ComponentFactory.Instance.creatComponentByStylename("selecteCP.ChapterRewardBtn2");
         _chapterPreBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.chapterPreBtn");
         _chapterNextBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.chapterNextBtn");
         _chapterRewardView = new ChapterRewardView();
         addChild(_map);
         addChild(_cpInfoView);
         addChild(_areaComboxBg);
         addChild(_areaCombox);
         addChild(_chapterRewardBtn1);
         addChild(_chapterRewardBtn2);
         addChild(_chapterPreBtn);
         addChild(_chapterNextBtn);
         addChild(_chapterRewardView);
         _chapterRewardView.x = 5;
         _chapterRewardView.y = 80;
         _chapterRewardView.visible = false;
         _cpInfoView.visible = false;
      }
      
      private function sortFun(param1:CampaignChapterInfo, param2:CampaignChapterInfo) : int
      {
         if(param1.chapterId < param2.chapterId)
         {
            return -1;
         }
         if(param1.chapterId > param2.chapterId)
         {
            return 1;
         }
         return 0;
      }
      
      private function defaultView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _chapterList = model.selectedLand.chapterDic.getList();
         _chapterList.sort(sortFun);
         _areaCombox.beginChanges();
         _areaCombox.selctedPropName = "text";
         var _loc1_:VectorListModel = _areaCombox.listPanel.vectorListModel;
         _loc1_.clear();
         _loc3_ = 0;
         while(_loc3_ < _chapterList.length)
         {
            _loc2_ = int((_chapterList[_loc3_] as CampaignChapterInfo).chapterId);
            if(_loc2_ <= model.maxChapter.chapterId)
            {
               _openLen = _openLen + 1;
               _loc1_.append(_chapterList[_loc3_]);
            }
            _loc3_++;
         }
         _areaCombox.listPanel.list.updateListView();
         _areaCombox.commitChanges();
         _areaCombox.listPanel.list.defaultSelectItemByCellValue = model.recentChapter;
         _currentIndex = _chapterList.indexOf(model.recentChapter);
         setBtnState();
      }
      
      private function initEvents() : void
      {
         _areaCombox.addEventListener("click",__onAreaComboxClick);
         _areaCombox.listPanel.list.addEventListener("listItemClick",__selectedChapterChange);
         _chapterRewardBtn1.addEventListener("click",__onRewardBtnClick);
         _chapterRewardBtn2.addEventListener("click",__onRewardBtnClick);
         _chapterPreBtn.addEventListener("click",__onAreaBtnClick);
         _chapterNextBtn.addEventListener("click",__onAreaBtnClick);
         model.addEventListener("SELECTED_AREA_CHANGE",__areaChangeHandler);
      }
      
      private function removeEvents() : void
      {
         _areaCombox.removeEventListener("click",__onAreaComboxClick);
         _areaCombox.listPanel.list.removeEventListener("listItemClick",__selectedChapterChange);
         _chapterRewardBtn1.removeEventListener("click",__onRewardBtnClick);
         _chapterRewardBtn2.removeEventListener("click",__onRewardBtnClick);
         _chapterPreBtn.removeEventListener("click",__onAreaBtnClick);
         _chapterNextBtn.removeEventListener("click",__onAreaBtnClick);
         model.removeEventListener("SELECTED_AREA_CHANGE",__areaChangeHandler);
      }
      
      private function __onAreaComboxClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function __areaChangeHandler(param1:SelectCampaignEvent) : void
      {
         _cpInfoView.visible = true;
         if(param1.data != null)
         {
            _point = param1.data as Point;
         }
         if(model.selectedArea && _point != null)
         {
            _cpInfoView.visible = true;
            _cpInfoView.x = model.selectedArea.posX + _point.x - 10;
            _cpInfoView.y = model.selectedArea.posY + _point.y - 200;
            if(_cpInfoView.y < 0)
            {
               if(_cpInfoView.x > 620)
               {
                  _cpInfoView.tipsGotoFrame(3);
                  _cpInfoView.x -= 317;
               }
               else
               {
                  _cpInfoView.tipsGotoFrame(2);
               }
               _cpInfoView.y += 135;
            }
            else if(_cpInfoView.x > 620)
            {
               _cpInfoView.tipsGotoFrame(4);
               _cpInfoView.x -= 317;
            }
            else
            {
               _cpInfoView.tipsGotoFrame(1);
            }
         }
         else
         {
            _cpInfoView.visible = false;
         }
         if(model.selectedChapter.isAllOpenArea())
         {
            _chapterRewardBtn1.visible = false;
            _chapterRewardBtn2.visible = true;
         }
         else
         {
            _chapterRewardBtn1.visible = true;
            _chapterRewardBtn2.visible = false;
         }
      }
      
      private function __onAreaBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!model.selectedChapter.isAllLoaded())
         {
            return;
         }
         var _loc2_:int = _chapterList.indexOf(model.selectedChapter);
         switch(param1.target)
         {
            case _chapterPreBtn:
               if(_loc2_ > 0)
               {
                  _currentIndex = _loc2_ - 1;
                  model.selectedChapter = _chapterList[_currentIndex];
               }
               break;
            case _chapterNextBtn:
               if(model.selectedChapter.chapterId < model.maxChapter.chapterId)
               {
                  _currentIndex = _loc2_ + 1;
                  model.selectedChapter = _chapterList[_currentIndex];
               }
         }
         _areaCombox.listPanel.list.defaultSelectItemByCellValue = model.selectedChapter;
         refreshFallGoods();
         setBtnState();
      }
      
      private function setBtnState() : void
      {
         _chapterPreBtn.enable = _currentIndex > 0;
         _chapterNextBtn.enable = _currentIndex < _openLen - 1;
      }
      
      private function __onRewardBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _chapterRewardView.visible = !_chapterRewardView.visible;
      }
      
      private function __selectedChapterChange(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("022");
         if(param1.cellValue == model.selectedChapter)
         {
            return;
         }
         model.selectedChapter = param1.cellValue as CampaignChapterInfo;
         _currentIndex = _chapterList.indexOf(model.selectedChapter);
         refreshFallGoods();
         setBtnState();
      }
      
      private function refreshFallGoods() : void
      {
         var _loc3_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         clearFallGoodsCell();
         var _loc7_:Array = TempleteManager.instance.districtTemplateCate.getTemplatesByID(model.selectedChapter.chapterId);
         if(!_loc7_ || _loc7_.length == 0)
         {
            return;
         }
         for each(var _loc2_:DistrictRewardTemplate in _loc7_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("selecteCP.DistrictGoodsCell");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_.ItemId;
            _loc5_.count = _loc2_.Count;
            _loc3_.data = _loc5_;
            _chapterRewardView.chapterRewardBox.addChild(_loc3_);
         }
         _chapterRewardView.chapterRewardBox.refreshChildPos();
         var _loc4_:Array = TempleteManager.instance.districtSSSTemplateCate.getTemplatesByID(model.selectedChapter.chapterId);
         if(!_loc4_ || _loc4_.length == 0)
         {
            _chapterRewardView.chapterTipAsset.visible = true;
            return;
         }
         for each(var _loc1_:DistrictRewardTemplate in _loc4_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("selecteCP.DistrictGoodsCell");
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc1_.ItemId;
            _loc8_.count = _loc1_.Count;
            _loc6_.data = _loc8_;
            _chapterRewardView.chapterSSSBox.addChild(_loc6_);
         }
         _chapterRewardView.chapterSSSBox.refreshChildPos();
         _chapterRewardView.chapterTipAsset.visible = false;
      }
      
      private function clearFallGoodsCell() : void
      {
         _chapterRewardView.chapterRewardBox.disposeAllChildren();
         _chapterRewardView.chapterRewardBox.refreshChildPos();
         _chapterRewardView.chapterSSSBox.disposeAllChildren();
         _chapterRewardView.chapterSSSBox.refreshChildPos();
      }
      
      public function get cpMapView() : SelectCpMapView
      {
         return _map;
      }
      
      private function get model() : SelectCampaignModel
      {
         return FrameControllerManager.instance.selectCampaignControler.model;
      }
      
      public function get cpInfoView() : CampaignInfoView
      {
         return _cpInfoView;
      }
      
      public function dispose() : void
      {
         removeEvents();
         clearFallGoodsCell();
         ObjectUtils.disposeAllChildren(this);
         if(_chapterRewardView)
         {
            _chapterRewardView.dispose();
         }
         _chapterRewardView = null;
         if(_cpInfoView)
         {
            ObjectUtils.disposeObject(_cpInfoView);
         }
         _cpInfoView = null;
         if(_areaCombox)
         {
            ObjectUtils.disposeObject(_areaCombox);
         }
         _areaCombox = null;
         if(_map)
         {
            ObjectUtils.disposeObject(_map);
         }
         _map = null;
         if(_chapterRewardBtn1)
         {
            _chapterRewardBtn1.dispose();
         }
         _chapterRewardBtn1 = null;
         if(_chapterRewardBtn2)
         {
            _chapterRewardBtn2.dispose();
         }
         _chapterRewardBtn2 = null;
         if(_chapterPreBtn)
         {
            _chapterPreBtn.dispose();
         }
         _chapterPreBtn = null;
         if(_chapterNextBtn)
         {
            _chapterNextBtn.dispose();
         }
         _chapterNextBtn = null;
         _chapterList = null;
         ObjectUtils.disposeObject(_areaComboxBg);
         _areaComboxBg = null;
         _point = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

