package yishi.view.guild
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.vo.AlertInfo;
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MaskUtils;
   
   public class QteSkillGuide
   {
      
      private static var _qteGuideAler:QteUpgradeTipFrame;
      
      public function QteSkillGuide()
      {
         super();
      }
      
      public static function guide(param1:SkillInfo) : void
      {
         if(param1)
         {
            if(param1.templateInfo && param1.templateInfo.QTETime > 0)
            {
               if(PlayerManager.instance.currentPlayerModel.playerInfo.qteGuide == 0)
               {
                  guideForFirstQte(param1);
               }
               else
               {
                  guideForRestQte(param1);
               }
            }
         }
      }
      
      private static function guideForFirstQte(param1:SkillInfo) : void
      {
         var _loc3_:InteractiveObject = null;
         var _loc4_:Frame = FrameControllerManager.instance.armyController.getSkillFrame();
         if(_loc4_)
         {
            _loc3_ = _loc4_["getSkillItemByInfo"](param1);
            if(_loc3_)
            {
               MaskUtils.instance.dispose();
               MaskUtils.instance.maskShow();
               MaskUtils.instance.drawTarget(_loc3_,_loc3_);
            }
         }
         var _loc2_:QteGuideFrame = new QteGuideFrame("qteGuideConenct",new Point(-165,20),MaskUtils.instance.dispose,_loc3_);
         MaskUtils.instance.addChild(_loc2_);
         SocketSendManager.instance.sendQteGuideComplete();
         PlayerManager.instance.currentPlayerModel.playerInfo.qteGuide = 1;
      }
      
      private static function __qteGuideAlerResponse(param1:FrameEvent) : void
      {
      }
      
      private static function newQteGuideAler(param1:AlertInfo, param2:Point, param3:String) : void
      {
         cleanAlert();
         if(!showAlert())
         {
            return;
         }
         _qteGuideAler = ComponentFactory.Instance.creatComponentByStylename("noviceII.QteUpgradeTipFrame");
         _qteGuideAler.info = param1;
         _qteGuideAler.describeTitle(param3);
         _qteGuideAler.show(1);
         StageReferance.stage.focus = _qteGuideAler;
         if(_qteGuideAler.width + param2.x + 102 > StageReferance.stageWidth)
         {
            _qteGuideAler.x = param2.x - _qteGuideAler.width - 5;
         }
         else
         {
            _qteGuideAler.x = param2.x + 102;
         }
         _qteGuideAler.y = param2.y - 3;
      }
      
      private static function showAlert() : Boolean
      {
         var _loc2_:Date = SharedManager.instance.qteUpgradeCheckDate;
         var _loc3_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc4_:Boolean = SharedManager.instance.qteUpgrade;
         if(!_loc4_ || _loc2_.month <= _loc2_.month && _loc2_.date < _loc3_.date)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public static function cleanAlert() : void
      {
         if(_qteGuideAler)
         {
            _qteGuideAler.dispatchEvent(new FrameEvent(1));
         }
      }
      
      private static function guideForRestQte(param1:SkillInfo) : void
      {
         var _loc6_:InteractiveObject = null;
         var _loc3_:AlertInfo = null;
         var _loc5_:String = null;
         var _loc2_:Array = null;
         var _loc8_:String = null;
         var _loc4_:String = null;
         var _loc7_:Frame = FrameControllerManager.instance.armyController.getSkillFrame();
         if(_loc7_)
         {
            _loc6_ = _loc7_["getSkillItemByInfo"](param1);
            if(_loc6_)
            {
               _loc3_ = new AlertInfo();
               _loc3_.mutiline = true;
               _loc3_.buttonGape = 15;
               _loc5_ = param1.templateInfo.Description;
               _loc2_ = _loc5_.split("\n");
               _loc5_ = _loc2_[_loc2_.length - 1];
               if(_loc5_.indexOf("QTE") == -1)
               {
                  _loc5_ = param1.templateInfo.Description;
               }
               else
               {
                  _loc8_ = LanguageMgr.GetTranslation("yishi.view.guild.QteSkillGuide.useWords");
                  _loc5_ = _loc8_ + _loc5_;
               }
               _loc4_ = LanguageMgr.GetTranslation("yishi.view.guild.QteSkillGuide.alerInfo");
               _loc3_.data = _loc5_;
               _loc3_.title = LanguageMgr.GetTranslation("public.prompt");
               _loc3_.showCancel = false;
               _loc3_.showSubmit = false;
               _loc3_.mutiline = true;
               newQteGuideAler(_loc3_,_loc6_.localToGlobal(new Point(0,0)),_loc4_);
            }
         }
      }
   }
}

