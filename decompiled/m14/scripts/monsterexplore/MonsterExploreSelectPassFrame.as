package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import monsterexplore.item.MonsterExploreChapterNodeItem;
   import monsterexplore.view.MonsterExploreNodeDetailView;
   import mvc.ModuleFrameInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.DashedLine;
   import yishi.view.base.PageBar;
   
   public class MonsterExploreSelectPassFrame extends Frame implements IManualSize
   {
      
      private var _border:MovieClip;
      
      private var _mapCon:Component;
      
      private var _mapShape:Bitmap;
      
      private var _mapIcon:MovieClip;
      
      private var _pageBar:PageBar;
      
      private var _nodeCon:Component;
      
      private var _titleBack:Bitmap;
      
      private var _titleBit:Bitmap;
      
      private var _chapterBack:Bitmap;
      
      private var _chapterNameText:GradientText;
      
      private var _mapNodeCon:Component;
      
      private var openDashy:DashedLine;
      
      private var closeDashy:DashedLine;
      
      private var nodeList:Vector.<MonsterExploreChapterNodeItem>;
      
      private var _rewardView:MonsterExploreNodeDetailView;
      
      private var chapterId:int;
      
      private var nodeId:int;
      
      private var chaptertempInfo:MonsterExploreTempInfo;
      
      private var nodeTempInfo:MonsterExploreTempInfo;
      
      public function MonsterExploreSelectPassFrame()
      {
         super();
         chapterId = exploreModel.curChapterId;
         nodeId = exploreModel.curNodeId;
         initView();
         initPageView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,945,550);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.border");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreSelectPassFrame.pageBar");
         _mapCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreSelectPassFrame.MapContiner");
         _mapShape = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreSelectPassFrame.MapShape");
         _nodeCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.nodeCon");
         _titleBit = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreSelectPassFrame.titleBit");
         _rewardView = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.rewardView");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreSelectPassFrame.titleBack");
         _chapterBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreSelectPassFrame.chapterBack");
         _chapterNameText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreSelectPassFrame.chapterNameText");
         _mapNodeCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreSelectPassFrame.mapNodeCon");
         openDashy = new DashedLine(2,16777011,1,[6,2,6,2]);
         closeDashy = new DashedLine(2,6710886,1,[6,2,6,2]);
         addToContent(_mapCon);
         addToContent(_border);
         addToContent(_titleBack);
         addToContent(_titleBit);
         addToContent(_chapterBack);
         addToContent(_chapterNameText);
         addToContent(_pageBar);
         addToContent(_mapNodeCon);
         addToContent(_rewardView);
         _mapNodeCon.addChild(openDashy);
         _mapNodeCon.addChild(closeDashy);
         _mapNodeCon.addChild(_nodeCon);
         _rewardView.visible = false;
         _rewardView.mouseEnabled = false;
         _mapCon.addChild(_mapShape);
         _mapShape.width = 930;
      }
      
      private function initPageView() : void
      {
         var _loc1_:Array = exploreModel.chapterTempDic.getList();
         _loc1_.sortOn("ChapterId",16);
         _pageBar.setAutoPagingData(_loc1_,1);
         _pageBar.setCurPage(getInitPageByChapterId(chapterId));
      }
      
      private function getInitPageByChapterId(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = exploreModel.chapterTempDic.getList();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].ChapterId == param1)
            {
               return _loc3_ + 1;
            }
            _loc3_++;
         }
         return 1;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pageBar.addEventListener("change",__pageChangeHandler);
         MsgMan.addObserver("EXPLORE_CLICK_NODE",this,__updateClickNodeHandler);
         MsgMan.addObserver("EXPLORE_NODE_CHANGE",this,__updateNodeSelectHandler);
         MsgMan.addObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
         MsgMan.notifyObserver("MOPUP_MAINSWEEP_OPEN");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",__pageChangeHandler);
         }
         MsgMan.removeObserver("EXPLORE_CLICK_NODE",this,__updateClickNodeHandler);
         MsgMan.removeObserver("EXPLORE_NODE_CHANGE",this,__updateNodeSelectHandler);
         MsgMan.removeObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
         MsgMan.notifyObserver("MOPUP_MAINSWEEP_CLOSE");
      }
      
      private function __mopupBossInfoHandler(param1:String, param2:Object) : void
      {
         var _loc3_:String = _rewardView.data.NodeName;
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","WIN_REWARD_FRAME",_loc3_);
      }
      
      private function __updateNodeSelectHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __updateClickNodeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:MonsterExploreChapterNodeItem = param2 as MonsterExploreChapterNodeItem;
         if(!_loc3_ || !_loc3_.data)
         {
            return;
         }
         _rewardView.visible = true;
         _rewardView.data = _loc3_.data;
         _rewardView.x = _loc3_.x + 25;
         _rewardView.y = _loc3_.y - 70;
         if(_rewardView.y < 250)
         {
            if(_rewardView.x > 620)
            {
               _rewardView.tipsGotoFrame(3);
               _rewardView.x -= 320;
            }
            else
            {
               _rewardView.tipsGotoFrame(2);
            }
         }
         else if(_rewardView.x > 620)
         {
            _rewardView.tipsGotoFrame(4);
            _rewardView.x -= 320;
            _rewardView.y -= 145;
         }
         else
         {
            _rewardView.tipsGotoFrame(1);
            _rewardView.y -= 145;
         }
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         var _loc2_:Array = _pageBar.getCurPageDatas();
         chapterId = _loc2_[0].ChapterId;
         _rewardView.visible = false;
         refreshView();
      }
      
      private function refreshMap() : void
      {
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         if(!chaptertempInfo)
         {
            return;
         }
         var _loc1_:String = PathManager.getMonsterChapterMapPath(int(chaptertempInfo.ChapterMapPath));
         LoaderManagerII.instance.load(_loc1_,2,8,__onMapLoadComplete);
      }
      
      private function __onMapLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         if(param2)
         {
            _mapIcon = param2 as MovieClip;
            _mapIcon.width = 930;
            _mapCon.addChildAt(_mapIcon,0);
         }
      }
      
      private function refreshView() : void
      {
         chaptertempInfo = exploreModel.chapterTempDic[chapterId];
         nodeTempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(chapterId,nodeId);
         _chapterNameText.text = chaptertempInfo.ChapterName;
         refreshMap();
         refreshNodeView();
      }
      
      private function refreshNodeView() : void
      {
         ObjectUtils.disposeAllChildren(_nodeCon);
         nodeList = new Vector.<MonsterExploreChapterNodeItem>();
         var _loc1_:Array = showList;
         if(_loc1_ == null || _loc1_.length <= 0)
         {
            openDashy.clear();
            closeDashy.clear();
            return;
         }
         if(chapterId > exploreModel.maxChapterId)
         {
            openDashy.clear();
            drwaLine(0,_loc1_.length,closeDashy);
         }
         else if(chapterId == exploreModel.maxChapterId && exploreModel.maxNodeId < showList.length)
         {
            drwaLine(0,exploreModel.maxNodeId + 1,openDashy,false);
            drwaLine(exploreModel.maxNodeId + 1,_loc1_.length,closeDashy,true);
         }
         else
         {
            closeDashy.clear();
            drwaLine(0,_loc1_.length,openDashy);
         }
      }
      
      private function drwaLine(param1:int, param2:int, param3:DashedLine, param4:Boolean = false) : void
      {
         var _loc5_:MonsterExploreChapterNodeItem = null;
         var _loc7_:MonsterExploreTempInfo = null;
         var _loc6_:MonsterExploreTempInfo = null;
         var _loc8_:int = 0;
         param3.clear();
         var _loc9_:Array = showList;
         _loc8_ = param1;
         while(_loc8_ < param2)
         {
            _loc5_ = new MonsterExploreChapterNodeItem();
            _loc7_ = _loc9_[_loc8_];
            _loc5_.data = _loc7_;
            _nodeCon.addChild(_loc5_);
            _loc5_.x = _loc7_.PosX;
            _loc5_.y = _loc7_.PosY;
            if(param4 && _loc8_ == param1 && param1 >= 1)
            {
               _loc6_ = _loc9_[param1 - 1];
               if(_loc6_)
               {
                  param3.moveTo(_loc6_.PosX + 25,_loc6_.PosY + 25);
                  param3.lineTo(_loc7_.PosX + 25,_loc7_.PosY + 25);
               }
            }
            else if(_loc8_ == param1)
            {
               param3.moveTo(_loc7_.PosX + 25,_loc7_.PosY + 25);
            }
            else
            {
               param3.lineTo(_loc7_.PosX + 25,_loc7_.PosY + 25);
            }
            nodeList.push(_loc5_);
            _loc8_++;
         }
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
      
      private function get showList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = exploreModel.exploreNodeTempDic[chapterId];
         for each(var _loc3_:MonsterExploreTempInfo in _loc2_)
         {
            _loc1_.push(_loc3_);
         }
         _loc1_.sortOn("NodeId",16);
         return _loc1_;
      }
      
      private function getNodeIndex(param1:int, param2:int) : int
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = 1;
         while(_loc5_ < param1)
         {
            _loc3_ = exploreModel.exploreNodeTempDic[_loc5_];
            _loc4_ += _loc3_.length;
            _loc5_++;
         }
         return _loc4_ + param2;
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onMapLoadComplete);
         ObjectUtils.disposeObject(_mapCon);
         _mapCon = null;
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_mapShape);
         _mapShape = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeViolentMc(_border);
         _border = null;
         ObjectUtils.disposeObject(_titleBit);
         _titleBit = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(openDashy);
         openDashy = null;
         ObjectUtils.disposeObject(closeDashy);
         closeDashy = null;
         ObjectUtils.disposeObject(_chapterBack);
         _chapterBack = null;
         ObjectUtils.disposeObject(_chapterNameText);
         _chapterNameText = null;
         ObjectUtils.disposeObject(_mapNodeCon);
         _mapNodeCon = null;
         ObjectUtils.disposeObject(_nodeCon);
         _nodeCon = null;
         LogicUtils.disposeDisplayCollection(nodeList);
         nodeList = null;
         super.dispose();
      }
   }
}

