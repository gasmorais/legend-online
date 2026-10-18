package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringUtil;
   
   public class TaskDescribeViewII extends Sprite implements Disposeable
   {
      
      private var _titleBack:Bitmap;
      
      private var _title:Bitmap;
      
      public var desribeTxt:FilterFrameText;
      
      public function TaskDescribeViewII()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.task.TitleBack");
         _title = ComponentFactory.Instance.creatBitmap("asset.task.DescribeTxt");
         desribeTxt = ComponentFactory.Instance.creatComponentByStylename("task.DescribeTxt");
         addChild(_titleBack);
         addChild(_title);
         addChild(desribeTxt);
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc5_:OfferRewardConditionTemplate = null;
         var _loc8_:RingTask = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         var _loc7_:CampaignTemplate = null;
         if(param1 is TaskTemplate)
         {
            desribeTxt.htmlText = param1.Detail;
         }
         else if(param1 is BaseOfferReward)
         {
            desribeTxt.htmlText = param1.rewardTemp.Detail;
         }
         else if(param1 is MarryTask)
         {
            desribeTxt.htmlText = param1.marryTaskTemp.Detail;
         }
         else if(param1 is RingTask)
         {
            _loc2_ = (param1 as RingTask).ringTaskTemp.Detail;
            _loc5_ = RingTaskManager.instance.getCurrCondition();
            _loc8_ = RingTaskManager.instance.getRingTask();
            if(_loc8_)
            {
               switch(int(_loc5_.CondictionType) - 18)
               {
                  case 0:
                     _loc7_ = TempleteManager.instance.getCampaignTemplateById(_loc8_.currTask.condition_2);
                     _loc2_ = _loc2_.replace("{0}",_loc7_.CampaignName);
                     break;
                  case 1:
                     _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_.currTask.condition_3);
                     switch(int(_loc8_.currTask.condition_2) - 2)
                     {
                        case 0:
                           _loc6_ = LanguageMgr.GetTranslation("public.consortia");
                           break;
                        case 1:
                           _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.pvp");
                           break;
                        case 2:
                           _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.Maze");
                     }
                     _loc3_ = _loc4_.TemplateName;
                     _loc2_ = StringUtil.replace(_loc2_,"{0}",_loc3_);
                     _loc2_ = _loc2_.replace("{1}",_loc6_);
               }
            }
            desribeTxt.htmlText = _loc2_;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(desribeTxt);
         desribeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

