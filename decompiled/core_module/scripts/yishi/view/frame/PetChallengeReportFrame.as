package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.petchallenge.PetChallengeModel;
   import mvc.module.petchallenge.PetChallengeObjectData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.cate.PetChallengeRewardCate;
   import yishi.datas.templates.cate.PetChallengeRewardTemplate;
   import yishi.manager.TempleteManager;
   
   public class PetChallengeReportFrame extends Frame
   {
      
      public static const RANK_DAY_MAX:int = 200;
      
      public static const RANK_WEEK_MAX:int = 200;
      
      private var _bg:MutipleImage;
      
      private var _rankInfoImg1:Bitmap;
      
      private var _rankInfoImg2:Bitmap;
      
      private var _rankTxt:FilterFrameText;
      
      private var _groupName:GradientText;
      
      private var _prizeTxt1:FilterFrameText;
      
      private var _prizeTxt2:FilterFrameText;
      
      private var _prizeTxt3:FilterFrameText;
      
      private var _prizeTxt4:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _data:Object;
      
      public function PetChallengeReportFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameBg");
         _rankInfoImg1 = ComponentFactory.Instance.creatBitmap("asset.petchallenge.PetDayRankTxt");
         _rankInfoImg2 = ComponentFactory.Instance.creatBitmap("asset.petchallenge.PetWeekRankTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameRankTxt");
         _groupName = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrame.groupName");
         _prizeTxt1 = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameTxt1");
         _prizeTxt2 = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameTxt2");
         _prizeTxt3 = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameTxt3");
         _prizeTxt4 = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameTxt4");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeReportFrameConfirmBtn");
         _rankInfoImg1.visible = false;
         _rankInfoImg2.visible = false;
         addToContent(_bg);
         addToContent(_rankInfoImg1);
         addToContent(_rankInfoImg2);
         addToContent(_rankTxt);
         addToContent(_groupName);
         addToContent(_prizeTxt1);
         addToContent(_prizeTxt2);
         addToContent(_prizeTxt3);
         addToContent(_prizeTxt4);
         addToContent(_confirmBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function set data(param1:Object) : void
      {
         var _loc7_:PetChallengeObjectData = null;
         var _loc4_:int = 0;
         var _loc2_:PetChallengeRewardCate = null;
         var _loc5_:Array = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc7_ = _data["rank"] as PetChallengeObjectData;
            if(_loc7_ == null)
            {
               return;
            }
            _loc4_ = int(_data["type"]);
            _loc2_ = TempleteManager.instance.petChallengeRewardCate;
            _rankTxt.text = LanguageMgr.GetTranslation("PetChallengeInfoView.rankingLabel",_loc7_.ranking);
            _groupName.text = LanguageMgr.GetTranslation("petchallenge.views.PetChallengeInfoView.group" + model.getGroupIdByRankAndScore(_loc7_.ranking,_loc7_.score));
            if(_loc4_ == 2)
            {
               _rankInfoImg1.visible = false;
               _rankInfoImg2.visible = true;
               _loc5_ = _loc2_.getWeekRankingReward(_loc7_);
            }
            if(_loc5_)
            {
               _loc3_ = 1;
               for each(_loc6_ in _loc5_)
               {
                  if(_loc6_.RewardType == 2)
                  {
                     _prizeTxt4.text = _loc6_.rewardName;
                  }
                  else if(_loc6_.RewardType == 3)
                  {
                     _prizeTxt3.text = _loc6_.rewardName;
                  }
                  else if(_loc6_.RewardType == 1)
                  {
                     this["_prizeTxt" + _loc3_].text = _loc6_.rewardName;
                     if(_loc3_ <= 3)
                     {
                        _loc3_++;
                     }
                  }
               }
            }
            else
            {
               _prizeTxt1.text = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            }
         }
         else
         {
            _rankInfoImg1.visible = false;
            _rankInfoImg2.visible = false;
            _rankTxt.text = "";
            _groupName.text = "";
            _prizeTxt1.text = "";
            _prizeTxt2.text = "";
            _prizeTxt3.text = "";
            _prizeTxt4.text = "";
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            data = param1.frameData;
         }
         LayerManager.Instance.addToLayer(this,2,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankInfoImg1);
         _rankInfoImg1 = null;
         ObjectUtils.disposeObject(_rankInfoImg2);
         _rankInfoImg2 = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_groupName);
         _groupName = null;
         ObjectUtils.disposeObject(_prizeTxt1);
         _prizeTxt1 = null;
         ObjectUtils.disposeObject(_prizeTxt2);
         _prizeTxt2 = null;
         ObjectUtils.disposeObject(_prizeTxt3);
         _prizeTxt3 = null;
         ObjectUtils.disposeObject(_prizeTxt4);
         _prizeTxt4 = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         super.dispose();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

