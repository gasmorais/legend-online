package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.crossguild.CrossGuildTowerInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.CursorManagerII;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   
   public class CrossGuildWarTowerNodeView extends Component
   {
      
      private var _bloodBar:ProgressCommon;
      
      private var _nameBack:Bitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _lookBtn:BaseButton;
      
      private var _bufferContiner:Component;
      
      private var _bufferTextImage:Bitmap;
      
      private var _numBit:BitmapData;
      
      private var _numContiner:Component;
      
      private var _nodeContiner:Component;
      
      private var _nodeMc:MovieClip;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _attackImage:Bitmap;
      
      private var _attackMc:MovieClip;
      
      private var _troubleMc1:MovieClip;
      
      private var _troubleMc2:MovieClip;
      
      private var _troubleMc3:MovieClip;
      
      private var _data:CrossGuildTowerInfo;
      
      private var preTowerType:String = "";
      
      private var index:int;
      
      private var side:int;
      
      private var maxTroubleCount:int;
      
      public function CrossGuildWarTowerNodeView(param1:int, param2:int)
      {
         super();
         side = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nodeContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarNodeView.nodeContiner");
         _bloodBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerNodeView.bloodBar");
         _nameBack = ComponentFactory.Instance.creatBitmap("asset.CrossGuildWarTowerNodeView.nameBack");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerNodeView.nameText");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerNodeView.lookBtn");
         _bufferContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerNodeView.bufferContiner");
         _numContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerNodeView.numContiner");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildWarTowerNodeView.numBit");
         _bufferTextImage = ComponentFactory.Instance.creatBitmap("asset.CrossGuildWarTowerNodeView.bufferTextImage");
         _attackImage = ComponentFactory.Instance.creatBitmap("asset.CrossGuildWarTowerNodeView.attackImage");
         _attackMc = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTowerNodeView.attackMc" + side);
         _troubleMc1 = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTowerNodeView.troubleMc" + side + "1" + Math.ceil(Math.random() * 3));
         _troubleMc2 = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTowerNodeView.troubleMc" + side + "2" + Math.ceil(Math.random() * 3));
         _troubleMc3 = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTowerNodeView.troubleMc" + side + "3" + Math.ceil(Math.random() * 3));
         addChild(_nodeContiner);
         _nodeContiner.mouseChildren = false;
         addChild(_bloodBar);
         _bloodBar.mouseEnabled = false;
         addChild(_nameBack);
         addChild(_nameText);
         _nameText.setFrame(side + 1);
         addChild(_lookBtn);
         addChild(_bufferContiner);
         addChild(_attackMc);
         addChild(_attackImage);
         addChild(_troubleMc1);
         addChild(_troubleMc2);
         addChild(_troubleMc3);
         _attackImage.visible = false;
         initAroundMc(_attackMc);
         initAroundMc(_troubleMc1);
         initAroundMc(_troubleMc2);
         initAroundMc(_troubleMc3);
         _bufferContiner.addChild(_bufferTextImage);
         _bufferContiner.addChild(_numContiner);
         _bufferContiner.mouseEnabled = false;
         _bufferContiner.visible = false;
         _buildingFilter = new SimpleBuildingFilter();
         maxTroubleCount = model.attackConfigAry[3];
      }
      
      private function initAroundMc(param1:MovieClip) : void
      {
         param1.visible = false;
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         param1.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         _lookBtn.addEventListener("click",__lookDetailHandler);
         if(_nodeContiner)
         {
            _nodeContiner.addEventListener("mouseOver",__mouseOverHandler);
            _nodeContiner.addEventListener("mouseOut",__mouseOutHandler);
            _nodeContiner.addEventListener("click",__mouseClickHandler);
         }
         MsgMan.addObserver("WAR_OHTER_INFO_CHANGE",this,__towerInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",__lookDetailHandler);
         }
         if(_nodeContiner)
         {
            _nodeContiner.removeEventListener("mouseOver",__mouseOverHandler);
            _nodeContiner.removeEventListener("mouseOut",__mouseOutHandler);
            _nodeContiner.removeEventListener("click",__mouseClickHandler);
         }
         MsgMan.removeObserver("WAR_OHTER_INFO_CHANGE",this,__towerInfoChangeHandler);
      }
      
      private function __towerInfoChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:CrossGuildTowerInfo = param2 as CrossGuildTowerInfo;
         if(_loc3_ && _loc3_.teamId == data.teamId && _loc3_.towerId == data.towerId)
         {
            data = _loc3_;
         }
      }
      
      public function __lookDetailHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildTowerDetailFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildTowerDetailFrame",[data]);
         _loc2_.show();
      }
      
      public function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_nodeMc)
         {
            _buildingFilter.setBuildingOverFilter(_nodeMc["effect_area"]);
         }
         if(data.teamId != model.myTeamId)
         {
            CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
         }
      }
      
      public function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_nodeMc)
         {
            _buildingFilter.setBuildingOutFilter(_nodeMc["effect_area"]);
         }
         CursorManagerII.instance.resetCursor();
      }
      
      public function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildTowerAttackFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildTowerAttackFrame");
         _loc2_.refreshView(data);
         _loc2_.show();
      }
      
      public function get data() : CrossGuildTowerInfo
      {
         return _data;
      }
      
      public function set data(param1:CrossGuildTowerInfo) : void
      {
         _data = param1;
         if(!data)
         {
            return;
         }
         var _loc2_:String = side.toString() + data.towerType.toString() + data.state.toString();
         if(preTowerType != _loc2_)
         {
            if(_nodeMc && _nodeMc.parent)
            {
               _nodeMc.parent.removeChild(_nodeMc);
            }
            _nodeMc = ComponentFactory.Instance.creatCustomObject("CrossGuildWarNodeView.nodeMc" + _loc2_);
            if(!_nodeMc.parent)
            {
               _nodeContiner.addChild(_nodeMc);
            }
         }
         preTowerType = _loc2_;
         setHitArea();
         setShowAndPosition();
         setAroundMc();
      }
      
      private function setAroundMc() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(data.blood <= 0)
         {
            _attackImage.visible = false;
            initAroundMc(_attackMc);
            initAroundMc(_troubleMc1);
            initAroundMc(_troubleMc2);
            initAroundMc(_troubleMc3);
            return;
         }
         if(data.attackCount > 0)
         {
            setPlayMc(_attackMc);
            _attackImage.visible = true;
         }
         else
         {
            initAroundMc(_attackMc);
            _attackImage.visible = false;
         }
         initAroundMc(_troubleMc1);
         initAroundMc(_troubleMc2);
         initAroundMc(_troubleMc3);
         var _loc2_:Array = [1,2,3];
         if(data.troubleCount % maxTroubleCount != 0)
         {
            if(data.troubleCount % maxTroubleCount == 1)
            {
               _loc5_ = Math.random() * 3;
               setPlayMc(this["_troubleMc" + _loc2_[_loc5_]]);
            }
            else if(data.troubleCount % maxTroubleCount == 2)
            {
               _loc6_ = Math.random() * 3;
               _loc1_ = _loc2_.slice();
               _loc1_.splice(_loc6_,1);
               _loc3_ = 0;
               while(_loc3_ < _loc1_.length)
               {
                  _loc4_ = int(_loc1_[_loc3_]);
                  setPlayMc(this["_troubleMc" + _loc4_]);
                  _loc3_++;
               }
            }
            else
            {
               setPlayMc(_troubleMc1);
               setPlayMc(_troubleMc2);
               setPlayMc(_troubleMc3);
            }
         }
      }
      
      private function setPlayMc(param1:MovieClip) : void
      {
         param1.visible = true;
         param1.gotoAndPlay(1);
      }
      
      private function setHitArea() : void
      {
         var _loc2_:Sprite = null;
         var _loc5_:Number = Number(_nodeMc["effect_area"].x);
         var _loc4_:Number = Number(_nodeMc["effect_area"].y);
         var _loc3_:Number = Number(_nodeMc["effect_area"].width);
         var _loc6_:Number = Number(_nodeMc["effect_area"].height);
         var _loc1_:BitmapData = new BitmapData(_loc3_,_loc6_,true,0);
         _loc1_.draw(_nodeMc["effect_area"]);
         _loc2_ = DisplayUtils.getHitArea(_loc1_,5);
         _loc2_.x = _loc5_;
         _loc2_.y = _loc4_;
         _nodeContiner.hitArea = _loc2_;
         _nodeContiner.addChild(_loc2_);
      }
      
      public function get nodeCenterPoint() : Point
      {
         var _loc1_:Point = new Point();
         _loc1_.x = _nodeMc["effect_area"].x + _nodeMc["effect_area"].width / 2;
         _loc1_.y = _nodeMc["effect_area"].y + _nodeMc["effect_area"].height / 2;
         return _loc1_;
      }
      
      private function setShowAndPosition() : void
      {
         if(data.sealAry.length > 0)
         {
            NumberViewUtils.refreshValue(data.sealAry.length,_numContiner,_numBit,15,21,13,15,"0123456789");
            _bufferContiner.visible = true;
         }
         _nameText.text = data.towerId + "." + data.nickName;
         _bloodBar.value = data.blood / data.totalBlood;
         _bloodBar.text = "";
         _bloodBar.x = nodeCenterPoint.x - _bloodBar.width / 2;
         _bloodBar.y = nodeCenterPoint.y - _nodeMc["effect_area"].height / 2 - 15;
         _nameBack.x = nodeCenterPoint.x - _nameBack.width / 2;
         _nameBack.y = nodeCenterPoint.y + _nodeMc["effect_area"].height / 2 + 3;
         _nameText.x = _nameBack.x;
         _nameText.y = _nameBack.y + 2;
         _lookBtn.x = _nameBack.x + _nameBack.width;
         _lookBtn.y = _nameText.y - 4;
         _bufferContiner.x = _nameText.x;
         _bufferContiner.y = _nameText.y + 20;
         _numContiner.x = _bufferTextImage.x + _bufferTextImage.width + 3;
         _numContiner.y = _bufferTextImage.y + 2;
         _attackMc.x = _nodeMc["post4"].x;
         _attackMc.y = _nodeMc["post4"].y;
         _troubleMc1.x = _nodeMc["post1"].x;
         _troubleMc1.y = _nodeMc["post1"].y;
         _troubleMc2.x = _nodeMc["post2"].x;
         _troubleMc2.y = _nodeMc["post2"].y;
         _troubleMc3.x = _nodeMc["post3"].x;
         _troubleMc3.y = _nodeMc["post3"].y;
         _attackImage.x = nodeCenterPoint.x - _attackImage.width / 2;
         _attackImage.y = nodeCenterPoint.y - _attackImage.height / 2;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _buildingFilter = null;
         ObjectUtils.disposeObject(_nodeContiner);
         _nodeContiner = null;
         ObjectUtils.disposeObject(_bloodBar);
         _bloodBar = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
         ObjectUtils.disposeObject(_bufferContiner);
         _bufferContiner = null;
         ObjectUtils.disposeObject(_bufferTextImage);
         _bufferTextImage = null;
         ObjectUtils.disposeObject(_numContiner);
         _numContiner = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_attackImage);
         _attackImage = null;
         ObjectUtils.disposeViolentMc(_nodeMc);
         _nodeMc = null;
         ObjectUtils.disposeViolentMc(_attackMc);
         _attackMc = null;
         ObjectUtils.disposeViolentMc(_troubleMc1);
         _troubleMc1 = null;
         ObjectUtils.disposeViolentMc(_troubleMc2);
         _troubleMc2 = null;
         ObjectUtils.disposeViolentMc(_troubleMc3);
         _troubleMc3 = null;
         super.dispose();
      }
   }
}

