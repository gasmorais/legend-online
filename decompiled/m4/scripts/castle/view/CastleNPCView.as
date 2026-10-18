package castle.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.ai.AIPhysicsFourDirection;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.interfaces.ICheck;
   
   public class CastleNPCView extends AIPhysicsFourDirection implements ICheck
   {
      
      protected var _specialFront:MovieClip;
      
      protected var _standPos:Bitmap;
      
      private var _special:Boolean;
      
      private var _specialTotal:int = 0;
      
      private var _specialCurrent:int = 0;
      
      private var _specialCountList:Array = [75,125];
      
      private var _stand:Boolean;
      
      private var _standCount:int = 50;
      
      private var _standCurrent:int = 0;
      
      private var _dialogDic:Dictionary;
      
      private var _currentDiagIndex:int;
      
      public var depth:int;
      
      public var type:int;
      
      public var specialPoint:Dictionary;
      
      private var _dialogView:CastleDialogView;
      
      private var _filter:IBuildingFilter;
      
      private var _forceStand:Boolean;
      
      public function CastleNPCView(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip, param5:MovieClip)
      {
         super(param1,param2,param3,param4);
         _specialFront = param5;
         _standPos = ComponentFactory.Instance.creatBitmap("asset.core.StandShadowAsset");
         _standPos.x = -16;
         _standPos.y = -16;
         _standPos.scaleX = _standPos.scaleY = 0.4;
         _standPos.alpha = 0.8;
         initData();
         initEvent();
         _filter = new SimpleBuildingFilter();
         buttonMode = true;
      }
      
      public function get checkRect() : Rectangle
      {
         return new Rectangle(x,y,24,50);
      }
      
      private function initData() : void
      {
         _dialogDic = new Dictionary(true);
         var _loc18_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen1");
         var _loc20_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen2");
         var _loc15_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen3");
         var _loc17_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen4");
         _dialogDic[1] = [_loc18_,_loc20_,_loc15_,_loc17_];
         var _loc28_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlaman1");
         var _loc26_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlaman2");
         var _loc31_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlaman3");
         var _loc30_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicFlaman4");
         _dialogDic[2] = [_loc28_,_loc26_,_loc31_,_loc30_];
         var _loc22_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen1");
         var _loc4_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen2");
         var _loc3_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen3");
         var _loc1_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen4");
         _dialogDic[3] = [_loc22_,_loc4_,_loc3_,_loc1_];
         var _loc16_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldier1");
         var _loc21_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldier2");
         var _loc19_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldier3");
         var _loc32_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldier4");
         _dialogDic[4] = [_loc16_,_loc21_,_loc19_,_loc32_];
         var _loc7_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman1");
         var _loc8_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman2");
         var _loc27_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman3");
         var _loc29_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman4");
         _dialogDic[5] = [_loc7_,_loc8_,_loc27_,_loc29_];
         var _loc13_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDinluo1");
         var _loc11_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDinluo2");
         var _loc6_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDinluo3");
         var _loc5_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDinluo4");
         _dialogDic[6] = [_loc13_,_loc11_,_loc6_,_loc5_];
         var _loc2_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey1");
         var _loc24_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey2");
         var _loc25_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey3");
         var _loc23_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey4");
         _dialogDic[8] = [_loc2_,_loc24_,_loc25_,_loc23_];
         var _loc12_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader1");
         var _loc14_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader2");
         var _loc9_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader3");
         var _loc10_:String = LanguageMgr.GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader4");
         _dialogDic[7] = [_loc12_,_loc14_,_loc9_,_loc10_];
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _filter.setLightFilter(this);
         _forceStand = true;
         stand = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(this);
         _forceStand = false;
         stand = true;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc5_:Point = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         _filter.setNormalFilter(this);
         var _loc2_:String = _dialogDic[type][_currentDiagIndex] as String;
         _currentDiagIndex = _currentDiagIndex + 1;
         if(_currentDiagIndex == _dialogDic[type].length)
         {
            _currentDiagIndex = 0;
         }
         if(_dialogView)
         {
            _dialogView.dispose();
            _dialogView = null;
            stand = true;
            return;
         }
         _dialogView = new CastleDialogView(type,callBack);
         if(_dialogView)
         {
            _loc5_ = parent.localToGlobal(new Point(x,y - displayHeight));
            _dialogView.scaleX = _dialogView.scaleY = 0.2;
            _dialogView.setContent(_loc2_,_loc5_.x,_loc5_.y);
            _loc4_ = (StageReferance.stageWidth - _dialogView.viewRectangle.width) / 2;
            _loc3_ = (StageReferance.stageHeight - _dialogView.viewRectangle.height) / 2 - 80;
            TweenMax.to(_dialogView,0.5,{
               "scaleX":1,
               "scaleY":1,
               "x":_loc4_,
               "y":_loc3_
            });
            stand = true;
         }
      }
      
      private function callBack() : void
      {
         _dialogView = null;
         stand = true;
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
         if(param1.pathInfo.length == 1)
         {
            _stand = true;
         }
      }
      
      public function set stand(param1:Boolean) : void
      {
         _stand = param1;
         if(!_stand)
         {
            return;
         }
         _standCurrent = 0;
      }
      
      public function set special(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _special = param1;
         if(!_special)
         {
            return;
         }
         stand = param1;
         _specialCurrent = 0;
         if(_info.pathInfo.length == 1)
         {
            _loc2_ = int(Math.random() * 10) / 5;
            _specialTotal = _specialCountList[_loc2_];
         }
      }
      
      override public function execute() : void
      {
         if(_info.pathInfo.length == 1 && _special)
         {
            playSpecial();
            return;
         }
         if(_stand)
         {
            playStand();
            return;
         }
         if(_special)
         {
            playSpecial();
            return;
         }
         playWalk();
      }
      
      private function playStand() : void
      {
         if(_info.pathInfo.length == 1)
         {
            checkStandDirection(null);
            _info.currentFrame++;
            if(_info.currentFrame % 48 == 0 && !_special)
            {
               _info.currentFrame = 0;
               special = int(Math.random() * 10) < 1;
            }
            return;
         }
         if(_standCurrent < _standCount)
         {
            if(_standCurrent == 0)
            {
               checkStandDirection(_info.pathInfo[_info.nextIndex]);
            }
            _standCurrent = _standCurrent + 1;
            if(_dialogView || _forceStand)
            {
               _standCurrent = 0;
            }
         }
         else
         {
            if(!_special)
            {
               checkDirection(_info.pathInfo[info.nextIndex]);
            }
            _stand = false;
         }
      }
      
      private function playSpecial() : void
      {
         if(_specialTotal == 0)
         {
            checkSpecialDirection(_info.pathInfo[_info.nextIndex]);
            _specialTotal = (movieClip as MovieClip).totalFrames;
         }
         if(_specialCurrent < _specialTotal)
         {
            if(_info.pathInfo.length == 1 && _specialCurrent == 0)
            {
               checkSpecialDirection(null);
            }
            else if(_specialCurrent == 0)
            {
               checkSpecialDirection(_info.pathInfo[_info.nextIndex]);
            }
            _specialCurrent = _specialCurrent + 1;
         }
         else
         {
            if(_info.pathInfo.length == 1)
            {
               checkStandDirection(null);
            }
            else if(!_special)
            {
               checkDirection(_info.pathInfo[info.nextIndex]);
            }
            _special = false;
            stand = true;
         }
      }
      
      private function playWalk() : void
      {
         var _loc1_:Point = null;
         if(_info.pathInfo.length > _info.walkIndex)
         {
            if(info.currentFrame >= info.totalFrame)
            {
               _loc1_ = _info.pathInfo[info.walkIndexToNext] as Point;
               nextWalk(_loc1_);
            }
            else
            {
               info.currentFrame++;
               playMovie();
               if(walkRandomAction())
               {
                  return;
               }
            }
         }
         else if(info)
         {
            if(info.currentFrame < info.totalFrame - 1)
            {
               info.currentFrame++;
               playMovie();
               return;
            }
            if(info.currentFrame == info.totalFrame - 1)
            {
               info.currentFrame++;
               playMovie();
            }
            _info.pathInfo.reverse();
            _info.pathInfo = _info.pathInfo;
         }
      }
      
      private function walkRandomAction() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!_special && specialPoint[x + "_" + y])
         {
            _loc1_ = int(Math.random() * 10) < 10;
            if(checkWalkDirection(_info.pathInfo[_info.nextIndex]))
            {
               special = _loc1_;
            }
            else
            {
               stand = _loc1_;
            }
            if(_loc1_)
            {
               return true;
            }
            checkDirection(_info.pathInfo[info.nextIndex]);
         }
         return false;
      }
      
      private function checkWalkDirection(param1:Point) : Boolean
      {
         return int(this.y) < int(param1.y);
      }
      
      override protected function checkDirection(param1:Point, param2:int = 1) : int
      {
         if(int(this.y) < int(param1.y))
         {
            movieClip = _walkFontAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            movieClip = _walkBackAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         addChildAt(_standPos,0);
         return 0;
      }
      
      private function checkSpecialDirection(param1:Point) : Boolean
      {
         movieClip = _specialFront;
         addChildAt(_standPos,0);
         if(!param1)
         {
            return false;
         }
         if(int(this.y) < int(param1.y))
         {
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
            return true;
         }
         if(this.x < param1.x)
         {
            this.scaleX = 1;
         }
         else
         {
            this.scaleX = -1;
         }
         return false;
      }
      
      private function checkStandDirection(param1:Point) : void
      {
         movieClip = _standFrontAsset;
         addChildAt(_standPos,0);
         if(!param1)
         {
            return;
         }
         if(int(this.y) < int(param1.y))
         {
            movieClip = _standFrontAsset;
            addChildAt(_standPos,0);
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            movieClip = _standBackAsset;
            addChildAt(_standPos,0);
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_filter)
         {
            _filter.setNormalFilter(this);
         }
         _filter = null;
         removeEvent();
         ObjectUtils.disposeObject(_specialFront);
         _specialFront = null;
         ObjectUtils.disposeObject(_standPos);
         _standPos = null;
         ObjectUtils.disposeObject(_dialogView);
         _dialogView = null;
         _dialogDic = null;
         super.dispose();
      }
   }
}

