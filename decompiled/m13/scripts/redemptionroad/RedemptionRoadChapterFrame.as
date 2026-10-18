package redemptionroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.RedemptionRoadManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.redemptionroad.RedemptionRoadModel;
   import mvc.module.redemptionroad.RedemptionRoadNodeInfo;
   import redemptionroad.item.RedemptionRoadNodeItem;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class RedemptionRoadChapterFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _mainBg:MutipleImage;
      
      private var _leftFlower:Image;
      
      private var _rightFlower:Image;
      
      private var _diffImage:ScaleFrameImage;
      
      private var _layerText:FilterFrameText;
      
      private var _bufferTitle:FilterFrameText;
      
      private var _bufferDesc:FilterFrameText;
      
      private var _debufferTitle:FilterFrameText;
      
      private var _debufferDesc:FilterFrameText;
      
      private var _rewardBox:HBox;
      
      private var _startBtn:IconButton;
      
      private var _lineCon:Component;
      
      private var _nodeCon:Component;
      
      private var _nodeBg:ScaleFrameImage;
      
      private var _nodePanel:ScrollPanel;
      
      private var nodeInfo:RedemptionRoadNodeInfo;
      
      private var nodeItemDic:Dictionary;
      
      private var lineStyleObj:Object = {
         "-20":"asset.RedemptionRoad.line015",
         "-15":"asset.RedemptionRoad.line015",
         "-10":"asset.RedemptionRoad.line010",
         "-5":"asset.RedemptionRoad.line005",
         "0":"asset.RedemptionRoad.line000",
         "5":"asset.RedemptionRoad.line105",
         "10":"asset.RedemptionRoad.line110",
         "15":"asset.RedemptionRoad.line115",
         "20":"asset.RedemptionRoad.line115"
      };
      
      private var preLen:int = -1;
      
      public function RedemptionRoadChapterFrame()
      {
         super();
         initView();
         initNodeView();
         addEvent();
         model.selectPos = 0;
         if(model.nodeDic.getList().length <= 0)
         {
            RedemptionRoadManager.instance.sendRedemptionRoadRequest(0);
         }
         else
         {
            refreshView();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,565);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.border");
         _mainBg = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.mainBg");
         _leftFlower = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.leftFlower");
         _rightFlower = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.rightFlower");
         _layerText = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.layerText");
         _bufferTitle = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.bufferTitle");
         _bufferDesc = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.bufferDesc");
         _debufferTitle = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.debufferTitle");
         _debufferDesc = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.debufferDesc");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.rewardBox");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.startBtn");
         _diffImage = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.diffImage");
         _nodeBg = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeBg");
         _nodeCon = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeCon");
         _nodePanel = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodePanel");
         _lineCon = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.lineCon");
         addToContent(_border);
         addToContent(_mainBg);
         addToContent(_nodePanel);
         addToContent(_leftFlower);
         addToContent(_rightFlower);
         addToContent(_diffImage);
         addToContent(_layerText);
         addToContent(_bufferTitle);
         addToContent(_bufferDesc);
         addToContent(_debufferTitle);
         addToContent(_debufferDesc);
         addToContent(_rewardBox);
         addToContent(_startBtn);
         _nodePanel.setView(_nodeCon);
         _diffImage.setFrame(1);
         _leftFlower.mouseEnabled = _rightFlower.mouseEnabled = false;
         _bufferTitle.text = LanguageMgr.GetTranslation("RedemptionRoadChapterFrame.bufferTitle.text");
         _debufferTitle.text = LanguageMgr.GetTranslation("RedemptionRoadChapterFrame.debufferTitle.text");
      }
      
      private function initNodeView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:HBox = null;
         var _loc5_:int = 0;
         var _loc1_:RedemptionRoadNodeItem = null;
         _nodeCon.beginChanges();
         _nodeCon.addChild(_nodeBg);
         _nodeCon.addChild(_lineCon);
         _nodeBg.setFrame(1);
         var _loc4_:Array = ConfigInfoManager.instance.getRedemptionRoadLayerConfig();
         nodeItemDic = new Dictionary();
         _loc3_ = 1;
         while(_loc3_ <= _loc4_.length)
         {
            _loc2_ = int(_loc4_[_loc3_ - 1]);
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeBox");
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc1_ = new RedemptionRoadNodeItem(_loc5_,_loc2_);
               _loc6_.addChild(_loc1_);
               nodeItemDic[_loc3_ + "_" + _loc5_] = _loc1_;
               _loc5_++;
            }
            _loc6_.y = (_loc3_ - 1) * -141 + 1295;
            _nodeCon.addChild(_loc6_);
            _loc3_++;
         }
         _nodeCon.commitChanges();
         _nodePanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _startBtn.addEventListener("click",__startClickHandler);
         MsgMan.addObserver("USER_INFO_CHANGE",this,__userInfoBackHandler);
         MsgMan.addObserver("NODE_POS_SELECT",this,__nodePosChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startClickHandler);
         }
         MsgMan.removeObserver("USER_INFO_CHANGE",this,__userInfoBackHandler);
         MsgMan.removeObserver("NODE_POS_SELECT",this,__nodePosChangeHandler);
      }
      
      private function __startClickHandler(param1:MouseEvent) : void
      {
         if(!nodeInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         RedemptionRoadManager.instance.sendRedemptionRoadRequest(1,nodeInfo.id);
      }
      
      private function __nodePosChangeHandler(param1:String, param2:Object) : void
      {
         refreshView(false);
      }
      
      private function __userInfoBackHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView(param1:Boolean = true) : void
      {
         nodeInfo = model.getShowNodeInfo(model.selectPos);
         if(!nodeInfo)
         {
            return;
         }
         _diffImage.setFrame(model.difficulty);
         _nodeBg.setFrame(model.difficulty);
         _layerText.text = LanguageMgr.GetTranslation("RedemptionRoadChapterFrame.layerText.text",model.curLayer);
         var _loc2_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[nodeInfo.buff];
         _bufferDesc.text = _loc2_ ? _loc2_.Description : "";
         var _loc3_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[nodeInfo.debuff];
         _debufferDesc.text = _loc3_ ? _loc3_.Description : "";
         refreshReward();
         refeshNodeView();
         drawLineView();
         if(param1)
         {
            if(model.curLayer >= model.maxLayer)
            {
               _nodePanel.vScrollbar.scrollValue = 0;
            }
            else
            {
               _nodePanel.vScrollbar.scrollValue = (model.curLayer - 1) * -141 + 1270;
            }
         }
      }
      
      private function refreshReward() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         _rewardBox.removeAllChild();
         var _loc2_:Array = GoodsHelp.getCommonRewardAry(nodeInfo.rewards);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("RedemptionRoadChapterFrame.rewardItem");
            _loc1_.data = _loc2_[_loc3_];
            _rewardBox.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function refeshNodeView() : void
      {
         var _loc1_:RedemptionRoadNodeItem = null;
         for(var _loc2_:String in nodeItemDic)
         {
            _loc1_ = nodeItemDic[_loc2_];
            _loc1_.nodeInfo = model.nodeDic[_loc2_];
            _loc1_.refreshSelect();
         }
      }
      
      private function drawLineView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RedemptionRoadNodeInfo = null;
         var _loc10_:RedemptionRoadNodeItem = null;
         var _loc3_:int = 0;
         var _loc6_:RedemptionRoadNodeInfo = null;
         var _loc8_:RedemptionRoadNodeItem = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc7_:Bitmap = null;
         var _loc9_:int = 0;
         if(!model.roadPaths || preLen == model.roadPaths.length)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_lineCon);
         preLen = model.roadPaths.length;
         if(preLen <= 1)
         {
            return;
         }
         _nodeCon.beginChanges();
         _loc9_ = preLen - 1;
         while(_loc9_ >= 0)
         {
            if(_loc9_ > 0)
            {
               _loc2_ = int(model.roadPaths[_loc9_]);
               _loc1_ = model.getNodeInfoById(_loc2_);
               if(_loc1_)
               {
                  _loc10_ = nodeItemDic[_loc1_.layer + "_" + _loc1_.pos];
                  if(_loc10_)
                  {
                     _loc3_ = int(model.roadPaths[_loc9_ - 1]);
                     _loc6_ = model.getNodeInfoById(_loc3_);
                     if(_loc6_)
                     {
                        _loc8_ = nodeItemDic[_loc6_.layer + "_" + _loc6_.pos];
                        if(_loc8_)
                        {
                           _loc4_ = _loc10_.weight - _loc8_.weight;
                           _loc5_ = lineStyleObj[_loc4_];
                           _loc7_ = ComponentFactory.Instance.creatBitmap(_loc5_);
                           if(_loc4_ <= 0)
                           {
                              _loc7_.x = 252 + _loc10_.x + 60;
                           }
                           else
                           {
                              _loc7_.x = 252 + _loc10_.x + 50 - _loc7_.width - 25;
                           }
                           _loc7_.y = _loc10_.parent.y + 55;
                           _lineCon.addChild(_loc7_);
                        }
                     }
                  }
               }
            }
            _loc9_--;
         }
         _nodeCon.commitChanges();
         _nodePanel.invalidateViewport();
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
      
      private function get model() : RedemptionRoadModel
      {
         return RedemptionRoadManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("RedemptionRoadMainFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_mainBg);
         _mainBg = null;
         ObjectUtils.disposeObject(_layerText);
         _layerText = null;
         ObjectUtils.disposeObject(_bufferTitle);
         _bufferTitle = null;
         ObjectUtils.disposeObject(_bufferDesc);
         _bufferDesc = null;
         ObjectUtils.disposeObject(_debufferTitle);
         _debufferTitle = null;
         ObjectUtils.disposeObject(_debufferDesc);
         _debufferDesc = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_leftFlower);
         _leftFlower = null;
         ObjectUtils.disposeObject(_rightFlower);
         _rightFlower = null;
         ObjectUtils.disposeObject(_nodeBg);
         _nodeBg = null;
         ObjectUtils.disposeObject(_nodeCon);
         _nodeCon = null;
         ObjectUtils.disposeObject(_nodePanel);
         _nodePanel = null;
         ObjectUtils.disposeObject(_diffImage);
         _diffImage = null;
         ObjectUtils.disposeObject(_lineCon);
         _lineCon = null;
         LogicUtils.disposeDisplayCollection(nodeItemDic);
         nodeItemDic = null;
         lineStyleObj = null;
         model.selectPos = 0;
         super.dispose();
      }
   }
}

