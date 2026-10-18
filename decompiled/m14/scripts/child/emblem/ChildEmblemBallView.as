package child.emblem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.children.PosMsg;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EmblemInfo;
   import utils.LogicUtils;
   import yishi.filter.UIFilter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildEmblemBallView extends Component
   {
      
      private var _mc:MovieClip;
      
      private var _pos:int;
      
      private var _data:EmblemInfo;
      
      private var _changeBtn:IconButton;
      
      private var _upBtn:IconButton;
      
      private var _clickIndex:int = -1;
      
      private var _btnList:Vector.<BaseButton>;
      
      private var _filter:UIFilter;
      
      private var _buttonMc1:MovieClip;
      
      public function ChildEmblemBallView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("ChildEmblemBallView.shineMc");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.changeBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.upBtn");
         _btnList = new Vector.<BaseButton>();
         _filter = new UIFilter();
         _buttonMc1.gotoAndStop(1);
         addChild(_buttonMc1);
         addChild(_changeBtn);
         addChild(_upBtn);
         _changeBtn.visible = false;
         _upBtn.visible = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeViolentMc(_buttonMc1);
         _buttonMc1 = null;
         if(_changeBtn)
         {
            _changeBtn.dispose();
         }
         _changeBtn = null;
         if(_upBtn)
         {
            _upBtn.dispose();
         }
         _upBtn = null;
         cleanBtnList();
         LogicUtils.disposeDisplayCollection(_btnList);
         _btnList = null;
         _data = null;
         _filter = null;
      }
      
      public function set pos(param1:int) : void
      {
         if(param1 < 1 || param1 > 6)
         {
            return;
         }
         _pos = param1;
         if(_pos % 2 == 0)
         {
            _changeBtn.x = -92;
            _changeBtn.y = 13;
         }
         else
         {
            _changeBtn.x = 25;
            _changeBtn.y = 13;
         }
         _upBtn.x = _changeBtn.x;
         _upBtn.y = _changeBtn.y + 28;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:BaseButton = null;
         removeBtnEvent();
         cleanBtnList();
         if(!_mc)
         {
            if(_pos == 1)
            {
               _mc = ComponentFactory.Instance.creat("asset.ChildEmblemBallView.ballMc2");
            }
            else
            {
               _mc = ComponentFactory.Instance.creat("asset.ChildEmblemBallView.ballMc1");
            }
            _buttonMc1["pos"].addChild(_mc);
         }
         ObjectUtils.disposeAllChildren(_mc["ball1"]);
         ObjectUtils.disposeAllChildren(_mc["ball2"]);
         ObjectUtils.disposeAllChildren(_mc["ball3"]);
         _data = model.selectedChild.emblemList[_pos];
         _buttonMc1.gotoAndStop(1);
         _changeBtn.visible = false;
         _upBtn.visible = false;
         if(_data)
         {
            if(_data.resi1 > 0)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.backStyle = "asset.ChildEmblemBallView.ball" + (int(_data.resi1 - 1));
               _mc["ball1"].addChild(_loc1_);
               _loc1_.mask = _mc["mask1"];
               _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.ballTip" + _data.resi1,_data.getValueByIndex(1));
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.x = -9;
               _loc1_.y = -7;
               _mc["ball1"].addChild(_loc1_);
               _loc1_.mask = _mc["mask1"];
               _filter.setGrayFilter(_loc1_);
               if(_pos == 1)
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.UpGradeAttribute");
               }
               else
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.seledtedAttribute");
               }
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
               _buttonMc1.gotoAndPlay(1);
            }
            if(_data.resi2 > 0)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.backStyle = "asset.ChildEmblemBallView.ball" + (int(_data.resi2 - 1));
               _mc["ball2"].addChild(_loc1_);
               _loc1_.mask = _mc["mask2"];
               _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.ballTip" + _data.resi2,_data.getValueByIndex(2));
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.x = -9;
               _loc1_.y = -7;
               _mc["ball2"].addChild(_loc1_);
               _loc1_.mask = _mc["mask2"];
               _filter.setGrayFilter(_loc1_);
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               if(_pos == 1)
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.UpGradeAttribute");
               }
               else
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.seledtedAttribute");
               }
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
               _buttonMc1.gotoAndPlay(1);
            }
            if(_data.resi3 > 0)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.backStyle = "asset.ChildEmblemBallView.ball" + (int(_data.resi3 - 1));
               _mc["ball3"].addChild(_loc1_);
               _loc1_.mask = _mc["mask3"];
               _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.ballTip" + _data.resi3,_data.getValueByIndex(3));
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemBallView.ballBtn");
               _loc1_.x = -9;
               _loc1_.y = -7;
               _mc["ball3"].addChild(_loc1_);
               _loc1_.mask = _mc["mask3"];
               _filter.setGrayFilter(_loc1_);
               _loc1_.tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
               if(_pos == 1)
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("public.unopen");
               }
               else
               {
                  _loc1_.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.seledtedAttribute");
                  _buttonMc1.gotoAndPlay(1);
               }
               _loc1_.addEventListener("click",__ballBtnHandler);
               _btnList.push(_loc1_);
            }
            tipData = "";
         }
         else
         {
            tipStyle = "yishi.view.tips.OneLineTip";
            tipDirctions = _pos % 2 == 0 ? "1,2" : "2,1";
            isFollowMouse = false;
            tipGapH = 30;
            if(_pos == 1)
            {
               tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemTabView.openTip",1);
            }
            else
            {
               tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemTabView.openTip",_pos - 1);
            }
         }
      }
      
      private function initEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.addEventListener("click",__changeBtnHandler);
         }
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upBtnHandler);
         }
         MsgMan.addObserver("ChildEvent.EMBLEM_BALL_CLICK",this,__ballClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeBtnHandler);
         }
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upBtnHandler);
         }
         MsgMan.removeObserver("ChildEvent.EMBLEM_BALL_CLICK",this,__ballClickHandler);
         removeBtnEvent();
      }
      
      private function removeBtnEvent() : void
      {
         var _loc1_:int = 0;
         if(_btnList)
         {
            _loc1_ = 0;
            while(_loc1_ < _btnList.length)
            {
               _btnList[_loc1_].removeEventListener("click",__ballBtnHandler);
               _loc1_++;
            }
         }
      }
      
      private function cleanBtnList() : void
      {
         if(_btnList)
         {
            while(_btnList.length > 0)
            {
               _btnList.pop().dispose();
            }
         }
      }
      
      private function __changeBtnHandler(param1:MouseEvent) : void
      {
         if(_pos < 2 || _pos > 6)
         {
            return;
         }
         var _loc2_:Object = {
            "pos":_pos,
            "index":_clickIndex
         };
         ChildManager.instance.openEmblemChangeView(_loc2_);
         _changeBtn.visible = false;
         _upBtn.visible = false;
      }
      
      private function __upBtnHandler(param1:MouseEvent) : void
      {
         if(_pos < 2 || _pos > 6)
         {
            return;
         }
         var _loc2_:Object = {
            "pos":_pos,
            "index":_clickIndex
         };
         ChildManager.instance.openEmblemUpView(_loc2_);
         _changeBtn.visible = false;
         _upBtn.visible = false;
      }
      
      private function __ballClickHandler(param1:String, param2:Object) : void
      {
         if(int(param2) == _pos && _pos > 1)
         {
            _changeBtn.visible = true;
            _upBtn.visible = true;
         }
         else
         {
            _changeBtn.visible = false;
            _upBtn.visible = false;
         }
      }
      
      private function __ballBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:PosMsg = null;
         switch(param1.currentTarget)
         {
            case _btnList[0]:
               _clickIndex = 0;
               break;
            case _btnList[1]:
               _clickIndex = 1;
               break;
            case _btnList[2]:
               _clickIndex = 2;
         }
         var _loc3_:Object = {
            "pos":_pos,
            "index":_clickIndex
         };
         if(_pos == 1)
         {
            if(_clickIndex == 2)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.unopen"));
            }
            else if(_data["resi" + (_clickIndex + 1)] < 1)
            {
               _loc2_ = [];
               _loc4_ = new PosMsg();
               _loc4_.property = 1;
               _loc4_.order = _clickIndex;
               _loc2_.push(_loc4_);
               ChildSender.emblemSelect(model.selectedChild.childId,_pos,_loc2_);
            }
            else
            {
               ChildManager.instance.openEmblemUpView(_loc3_);
            }
         }
         else if(_data["resi" + (_clickIndex + 1)] > 1)
         {
            param1.stopPropagation();
            MsgMan.notifyObserver("ChildEvent.EMBLEM_BALL_CLICK",_pos);
         }
         else
         {
            ChildManager.instance.openEmblemChangeView(_loc3_);
         }
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

