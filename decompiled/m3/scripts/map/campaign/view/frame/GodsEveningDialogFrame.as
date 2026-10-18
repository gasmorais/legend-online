package map.campaign.view.frame
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   import map.net.MapSocketOuterManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PathManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GodsEveningDialogFrame extends PetLandDialogFrame
   {
      
      public function GodsEveningDialogFrame()
      {
         super();
      }
      
      override protected function refresh() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:Array = null;
         if(_data)
         {
            if(_data.param2 == 1)
            {
               _loc2_ = LanguageMgr.GetTranslation("public.colon",currentThane.nickName);
               _loc3_ = LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.content1");
               _loc1_ = [];
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.colon",_data.info.names);
               _loc3_ = LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.content2");
               _loc1_ = [LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.option1"),LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.option2")];
            }
            _itemList = new Vector.<CampaignDialogOptionItem>();
            _npcName.text = _loc2_;
            _content.htmlText = _loc3_;
            initOptions(_loc1_);
         }
         else
         {
            _npcName.text = "";
            _content.htmlText = "";
         }
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
      }
      
      override protected function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data)
         {
            if(param1.target == leaveItem)
            {
               MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,false);
               dispose();
            }
            else if(param1.target is CampaignDialogOptionItem)
            {
               if((param1.target as CampaignDialogOptionItem).text == LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.option1"))
               {
                  if(_selfArmy.isDie == 2 || _selfArmy.isDie == 10)
                  {
                     MapSocketOuterManager.sendFrameCallBackGodsEvening(mapId,_data.nodeId,true,1);
                     dispose();
                  }
                  else
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("godsEvening.campaign.npc.tip2"));
                     dispose();
                  }
               }
               else if((param1.target as CampaignDialogOptionItem).text == LanguageMgr.GetTranslation("godsEvening.GodsEveningDialogFrame.option2"))
               {
                  if(_selfArmy.isDie == 12 || _selfArmy.isDie == 10)
                  {
                     MapSocketOuterManager.sendFrameCallBackGodsEvening(mapId,_data.nodeId,true,2);
                     dispose();
                  }
                  else
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("godsEvening.campaign.npc.tip3"));
                     dispose();
                  }
               }
            }
         }
      }
      
      override protected function initOptions(param1:Array) : void
      {
         var _loc3_:CampaignDialogOptionItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(CampaignManager.instance.mapId);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new CampaignDialogOptionItem(mapId,_data.nodeId,param1[_loc4_],_loc4_);
            _vBox.addChild(_loc3_);
            _itemList[_loc4_] = _loc3_;
            _loc4_++;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc2_,_itemList.length);
         _vBox.addChild(leaveItem);
         _itemList.push(leaveItem);
      }
      
      override public function show(param1:CampaignNode) : void
      {
         var _loc2_:ThaneInfo = null;
         _data = param1;
         if(_data.param2 == 1)
         {
            _loc2_ = currentThane;
         }
         else
         {
            _loc2_ = GodsEveningManager.instance.model.getNpcNodeInfoByTeamAndType(_data.param1,_data.param2);
         }
         _iconView.icon = PathManager.solveHeadPath(getHalfBodyIdByHeadId(_loc2_.snsInfo.headId));
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         refresh();
         resetHeight();
         startTimer();
         LayerManager.Instance.addToLayer(this,3,true,true);
         CampaignManager.instance.mapModel.selectNode = null;
         y -= _iconView.y;
      }
      
      private function getHalfBodyIdByHeadId(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 100:
            case 101:
            case 102:
               _loc2_ = param1;
               break;
            case 8:
               _loc2_ = 103;
               break;
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
               _loc2_ = param1 + 1;
         }
         return _loc2_;
      }
      
      private function get currentThane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

