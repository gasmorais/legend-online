package map.campaign.view.ui.childwar
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class ChildWarUIView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var titleText:FilterFrameText;
      
      private var skillTextVbox:VBox;
      
      private var skillList:Vector.<FilterFrameText>;
      
      private var rewardImage:Bitmap;
      
      private var rewardHbox:HBox;
      
      private var rewardList:Vector.<BaseItemView>;
      
      private var bossBuffArr:Array = [];
      
      private var curDif:int = 0;
      
      public function ChildWarUIView()
      {
         super();
         model && model.campaignTemplate ? (curDif = model.campaignTemplate.DifficultyGrade - 1) : 0;
         bossBuffArr = ConfigInfoManager.instance.getChildWarBossBuffByDif(curDif);
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildWarUIView.back");
         titleText = ComponentFactory.Instance.creatComponentByStylename("ChildWarUIView.titleText");
         skillTextVbox = ComponentFactory.Instance.creatComponentByStylename("ChildWarUIView.skillTextVbox");
         rewardImage = ComponentFactory.Instance.creatBitmap("asset.ChildWarUIView.rewardImage");
         rewardHbox = ComponentFactory.Instance.creatComponentByStylename("ChildWarUIView.rewardHbox");
         addChild(back);
         addChild(titleText);
         addChild(skillTextVbox);
         addChild(rewardImage);
         addChild(rewardHbox);
         titleText.text = LanguageMgr.GetTranslation("ChildWarUIView.titleText.text");
      }
      
      private function initListView() : void
      {
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:BufferTemplateInfo = null;
         var _loc1_:FilterFrameText = null;
         var _loc10_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         skillList = new Vector.<FilterFrameText>();
         rewardList = new Vector.<BaseItemView>();
         var _loc3_:int = int(bossBuffArr.length);
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = bossBuffArr[_loc7_].split(",");
            _loc4_ = int(_loc5_[0]);
            _loc9_ = int(_loc5_[1]);
            _loc2_ = int(_loc5_[2]);
            _loc6_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc4_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildWarUIView.skillText");
            _loc1_.htmlText = _loc6_.BufferName;
            _loc1_.setFrame(1);
            skillTextVbox.addChild(_loc1_);
            skillList.push(_loc1_);
            _loc10_ = ComponentFactory.Instance.creatCustomObject("ChildWarUIView.rewardItem");
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc9_;
            _loc8_.count = _loc2_;
            _loc10_.data = _loc8_;
            _loc10_.filters = [];
            rewardHbox.addChild(_loc10_);
            rewardList.push(_loc10_);
            _loc7_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("CHILD_WAR_BUFF_CHANGE",this,__updateBuffHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("CHILD_WAR_BUFF_CHANGE",this,__updateBuffHandler);
      }
      
      private function __updateBuffHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:String = null;
         if(hasSkillArr == null)
         {
            return;
         }
         var _loc1_:int = int(bossBuffArr.length);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = bossBuffArr[_loc4_].split(",");
            _loc2_ = _loc3_[0];
            if(hasSkillArr.indexOf(_loc2_) != -1)
            {
               skillList[_loc4_].setFrame(1);
               rewardList[_loc4_].filters = [];
            }
            else
            {
               skillList[_loc4_].setFrame(2);
               rewardList[_loc4_].filters = [UIFilter.getGrayFilter()];
            }
            _loc4_++;
         }
      }
      
      private function get hasSkillArr() : Array
      {
         return CampaignManager.instance.childWarHasSkillArr;
      }
      
      private function get model() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(titleText);
         titleText = null;
         ObjectUtils.disposeObject(rewardImage);
         rewardImage = null;
         ObjectUtils.disposeObject(skillTextVbox);
         skillTextVbox = null;
         ObjectUtils.disposeObject(rewardHbox);
         rewardHbox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         LogicUtils.disposeDisplayCollection(rewardList);
         rewardList = null;
         super.dispose();
      }
   }
}

