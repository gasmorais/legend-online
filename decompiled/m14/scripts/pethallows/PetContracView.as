package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import utils.LogicUtils;
   import yishi.datas.templates.PetContracTemplateInfo;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class PetContracView extends Component
   {
      
      private var processImage:MutipleImage;
      
      private var processText:FilterFrameText;
      
      private var alertText:FilterFrameText;
      
      private var backMc:MovieClip;
      
      private var iconContiner:Component;
      
      private var iconList:Vector.<PetContracIconView>;
      
      private var processMcContiner:Component;
      
      private var processMc1:MovieClip;
      
      private var processMc2:MovieClip;
      
      private var processMc3:MovieClip;
      
      private var processMc4:MovieClip;
      
      private var processMc5:MovieClip;
      
      private var processMc6:MovieClip;
      
      private var hallowsMcView:PetHallowsMcView;
      
      private var posArr:Array = [[135,255],[135,125],[220,35],[465,255],[465,125],[380,35],[300,65],[300,330]];
      
      private var isFirst:Boolean = true;
      
      public function PetContracView()
      {
         super();
         initView();
         initListView();
         refreshMcState();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         processImage = ComponentFactory.Instance.creatComponentByStylename("PetContracView.processImage");
         processText = ComponentFactory.Instance.creatComponentByStylename("PetContracView.processText");
         alertText = ComponentFactory.Instance.creatComponentByStylename("PetContracView.alertText");
         backMc = ComponentFactory.Instance.creatCustomObject("PetContracView.backMc");
         iconContiner = ComponentFactory.Instance.creatComponentByStylename("PetContracView.iconContiner");
         processMcContiner = ComponentFactory.Instance.creatComponentByStylename("PetContracView.processMcContiner");
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            this["processMc" + _loc1_] = ComponentFactory.Instance.creatCustomObject("PetContracView.processMc" + _loc1_);
            this["processMc" + _loc1_].mouseChildren = this["processMc" + _loc1_].mouseEnabled = false;
            this["processMc" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         hallowsMcView = ComponentFactory.Instance.creatCustomObject("PetContracView.hallowsMcView");
         addChild(backMc);
         addChild(processImage);
         addChild(processText);
         addChild(alertText);
         addChild(processMcContiner);
         addChild(iconContiner);
         addChild(hallowsMcView);
         backMc.mouseChildren = backMc.mouseEnabled = false;
         backMc.play();
         iconContiner.mouseEnabled = false;
         processMcContiner.mouseChildren = processMcContiner.mouseEnabled = false;
         hallowsMcView.mouseChildren = hallowsMcView.mouseEnabled = false;
         alertText.text = LanguageMgr.GetTranslation("PetContracView.alertText.text");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetContracIconView = null;
         iconList = new Vector.<PetContracIconView>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("PetContracView.ContracIcon");
            iconContiner.addChild(_loc1_);
            iconList.push(_loc1_);
            _loc1_.x = posArr[_loc2_][0];
            _loc1_.y = posArr[_loc2_][1];
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("PET_HALLOWS_MAINMC_UPDATE",this,__updateMcHandler);
         MsgMan.addObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.addObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsUpdateMsgHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("PET_HALLOWS_MAINMC_UPDATE",this,__updateMcHandler);
         MsgMan.removeObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.removeObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsUpdateMsgHandler);
      }
      
      private function __hallowsUpdateMsgHandler(param1:String, param2:Object) : void
      {
         refreshView();
         if(isFirst)
         {
            refreshMcState();
         }
         isFirst = false;
      }
      
      private function __hallowsHeadSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshMcState();
      }
      
      private function __updateMcHandler(param1:String, param2:Object) : void
      {
         var _loc5_:PetContracTemplateInfo = null;
         var _loc7_:Array = null;
         var _loc6_:PetContracTemplateInfo = param2 as PetContracTemplateInfo;
         var _loc3_:int = -1;
         var _loc4_:Array = [1,2,4,5,6,7];
         switch(int(_loc6_.LineIndex) - 1)
         {
            case 0:
            case 1:
               _loc3_ = int(_loc6_.LineIndex);
               break;
            case 2:
            case 5:
               _loc7_ = model.getContracTempInfoByTypeAndIndex(model.selectedHallowsTemp.HallowType,9 - _loc6_.LineIndex);
               _loc5_ = _loc7_[_loc7_.length - 1];
               if(model.contracInfoDic[_loc5_.PetSonType] && model.contracInfoDic[_loc5_.PetSonType] == _loc5_.TemplateId)
               {
                  _loc3_ = 5;
               }
               else
               {
                  _loc3_ = -1;
               }
               break;
            case 3:
               _loc3_ = 3;
               break;
            case 4:
               _loc3_ = 4;
               break;
            case 6:
               _loc3_ = 6;
               break;
            case 7:
               _loc3_ = 8;
               break;
            default:
               _loc3_ = -1;
         }
         if(_loc3_ >= 1 && _loc3_ <= 6)
         {
            mcPlayHandler(_loc3_,_loc4_[_loc3_ - 1]);
         }
         else if(_loc3_ == 8)
         {
            hallowsMcView.playCurFrame(1);
            hallowsMcView.playLightMc();
         }
      }
      
      private function mcPlayHandler(param1:int, param2:int) : void
      {
         var mcIndex:int = param1;
         var iconIndex:int = param2;
         var curMc:MovieClip = this["processMc" + mcIndex];
         if(curMc && !curMc.parent)
         {
            processMcContiner.addChild(curMc);
         }
         curMc.gotoAndPlay(1);
         curMc.addFrameScript(curMc.totalFrames - 1,function():void
         {
            curMc.stop();
            iconList[iconIndex].playLightMc();
         });
      }
      
      private function refreshView() : void
      {
         var _loc4_:PetContracTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:PetContracTemplateInfo = null;
         if(!model.selectedHallowsTemp)
         {
            return;
         }
         var _loc1_:Array = showArr;
         _loc3_ = 0;
         while(_loc3_ < iconList.length)
         {
            _loc4_ = _loc1_[_loc3_];
            iconList[_loc3_].data = _loc4_ ? _loc4_ : null;
            if(_loc4_)
            {
               if(model.contracInfoDic[_loc4_.PetSonType])
               {
                  _loc2_ = TempleteManager.instance.petContracTemplateCate.getTemplateById(model.contracInfoDic[_loc4_.PetSonType]);
                  _loc5_ += _loc2_.Grades;
               }
            }
            _loc3_++;
         }
         processText.text = int(_loc5_ * 100 / 48) + "%";
      }
      
      private function refreshMcState() : void
      {
         var _loc6_:int = 0;
         var _loc12_:MovieClip = null;
         var _loc10_:Array = null;
         var _loc1_:int = 0;
         var _loc9_:PetContracTemplateInfo = null;
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:PetContracTemplateInfo = null;
         var _loc2_:PetContracTemplateInfo = null;
         if(!model.selectedHallowsTemp)
         {
            return;
         }
         var _loc8_:Array = [[0],[1],[3],[4],[2,5],[6]];
         var _loc3_:Array = showArr;
         _loc6_ = 1;
         while(_loc6_ <= _loc8_.length)
         {
            _loc12_ = this["processMc" + _loc6_];
            _loc12_.gotoAndStop(1);
            if(_loc12_ && _loc12_.parent)
            {
               _loc12_.parent.removeChild(_loc12_);
            }
            _loc10_ = _loc8_[_loc6_ - 1];
            _loc1_ = int(_loc10_.length);
            _loc11_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc1_)
            {
               _loc9_ = _loc3_[_loc10_[_loc7_]];
               if(_loc9_)
               {
                  if(model.contracInfoDic[_loc9_.PetSonType])
                  {
                     _loc4_ = TempleteManager.instance.petContracTemplateCate.getTemplateById(model.contracInfoDic[_loc9_.PetSonType]);
                     if(_loc4_)
                     {
                        _loc2_ = model.getContracTempInfoByPetSonTypeAndGrade(_loc4_.PetSonType,_loc4_.Grades + 1);
                        if(!_loc2_)
                        {
                           _loc11_++;
                        }
                     }
                  }
               }
               _loc7_++;
            }
            if(_loc11_ >= _loc1_)
            {
               processMcContiner.addChild(_loc12_);
               _loc12_.gotoAndStop(_loc12_.totalFrames);
            }
            _loc6_++;
         }
         hallowsMcView.hallowsType = model.selectedHallowsTemp.HallowType;
         var _loc5_:PetHallowsInfo = model.getHallowsInfoByHallowsType(model.selectedHallowsTemp.HallowType);
         if(_loc5_)
         {
            hallowsMcView.playCurFrame(11);
         }
         else
         {
            hallowsMcView.stopCurFrame(1);
         }
      }
      
      private function get showArr() : Array
      {
         var _loc1_:Array = [];
         if(!model.selectedHallowsTemp)
         {
            return _loc1_;
         }
         _loc1_ = model.getContracTempListByHallowsType(model.selectedHallowsTemp.HallowType);
         _loc1_.sortOn("LineIndex");
         return _loc1_;
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         posArr = null;
         ObjectUtils.disposeObject(processImage);
         processImage = null;
         ObjectUtils.disposeObject(processText);
         processText = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeViolentMc(backMc);
         backMc = null;
         ObjectUtils.disposeObject(iconContiner);
         iconContiner = null;
         ObjectUtils.disposeViolentMc(processMc1);
         processMc1 = null;
         ObjectUtils.disposeViolentMc(processMc2);
         processMc2 = null;
         ObjectUtils.disposeViolentMc(processMc3);
         processMc3 = null;
         ObjectUtils.disposeViolentMc(processMc4);
         processMc4 = null;
         ObjectUtils.disposeViolentMc(processMc5);
         processMc5 = null;
         ObjectUtils.disposeViolentMc(processMc6);
         processMc6 = null;
         ObjectUtils.disposeObject(hallowsMcView);
         hallowsMcView = null;
         ObjectUtils.disposeObject(processMcContiner);
         processMcContiner = null;
         LogicUtils.disposeDisplayCollection(iconList);
         super.dispose();
      }
   }
}

