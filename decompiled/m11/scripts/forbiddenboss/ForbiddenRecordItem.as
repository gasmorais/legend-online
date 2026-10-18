package forbiddenboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRecordMsg;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.StringHelper;
   
   public class ForbiddenRecordItem extends Component
   {
      
      private var _txt:FilterFrameText;
      
      public function ForbiddenRecordItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("forbiddenRecordItem.txt");
         addChild(_txt);
      }
      
      public function set data(param1:ForbiddenBossRecordMsg) : void
      {
         var _loc6_:String = param1.recordDate;
         var _loc3_:String = "<font color=\'#fc7d00\'> [" + param1.nickName + "] </font>";
         var _loc9_:ForbiddenBossTempInfo = TempleteManager.instance.forbiddenBossTempCate.getTempInfoById(param1.bossId);
         var _loc4_:int = int(_loc9_.Category >= 5 ? 4 : _loc9_.Category);
         var _loc7_:String = StringHelper.format("<font color={0}> {1} </font>",GoodsHelp.getGoodColorString(_loc4_ + 2),_loc9_.campaignName);
         var _loc2_:String = _loc9_.bossName;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = param1.itemId;
         var _loc8_:String = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc5_.templateInfo.Profile),_loc5_.templateInfo.TemplateName);
         _txt.htmlText = LanguageMgr.GetTranslation("forbiddenRecordItem.txt.text",_loc6_,_loc3_,_loc7_,_loc2_,_loc8_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

